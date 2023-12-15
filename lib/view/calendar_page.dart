import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salon_config_web/view/reservation_page.dart';
import 'package:salon_config_web/view/show_details_page.dart';
import 'package:table_calendar/table_calendar.dart';

import '../viewModel/customer_view_model.dart';
import '../viewModel/reservation_view_model.dart';
import 'input_details_form.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends ConsumerState<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Future(() async {
      await ref.read(customerNotifierProvider.notifier).fetchDates();
      await ref.read(reservationNotifierProvider.notifier).fetchReservations();
    });
    _startTimer();
  }

  // 2秒間隔で予約情報を取得
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (Timer timer) async {
        await ref
            .read(reservationNotifierProvider.notifier)
            .fetchReservations();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerNotifierProvider);
    final eventDates = customer.eventDates;
    final reservation = ref.watch(reservationNotifierProvider);
    final reservationDates = reservation.reservationList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        automaticallyImplyLeading: true, // この行を追加
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                debugPrint("Selected day: $selectedDay"); // 追加
                debugPrint("Event dates: $eventDates"); // 追加

                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowDetailsPage(
                      selectedDate: selectedDay,
                      eventDates: eventDates,
                      // reservationList: reservationDates,
                    ),
                  ),
                );
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(),
                selectedTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final dateKey = DateTime(date.year, date.month, date.day);
                  bool hasEvent =
                      eventDates != null && eventDates.containsKey(dateKey);
                  bool hasReservation = reservationDates != null &&
                      reservationDates.containsKey(dateKey);

                  if (hasEvent || hasReservation) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasEvent)
                          Container(
                            margin: const EdgeInsets.only(right: 4.0),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                        if (hasReservation)
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            color: Colors.blue,
                            child: const Text(
                              "予",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            ),
            const Gap(80),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InputDetailsForm(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("追加"),
                        SizedBox(width: 8),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReservationPage(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("予約する"),
                        SizedBox(width: 8),
                        Icon(Icons.book),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
