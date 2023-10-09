import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_config_web/view/show_details_page.dart';
import 'package:table_calendar/table_calendar.dart';

import '../viewModel/customer_view_model.dart';
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

  @override
  void initState() {
    super.initState();
    Future(() async {
      await ref.read(customerNotifierProvider.notifier).fetchDates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerNotifierProvider);
    final eventDates = customer.eventDates;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        automaticallyImplyLeading: true, // この行を追加
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
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
                  ),
                ),
              );
            },
            calendarStyle: const CalendarStyle(
                // ここでカレンダーのスタイルを調整できます
                ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final dateKey = DateTime(date.year, date.month, date.day);
                // bool hasReservation = true;

                // return Row(
                //   children: [
                //     if (eventDates != null && eventDates.containsKey(dateKey))
                //       Positioned(
                //         bottom: 4,
                //         child: Container(
                //           width: 6,
                //           height: 6,
                //           decoration: const BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: Colors.red,
                //           ),
                //         ),
                //       ),
                //     if (hasReservation)
                //       const Positioned(
                //         bottom: 4,
                //         right: 4,
                //         child: Text(
                //           "予約",
                //           style: TextStyle(
                //             fontSize: 8,
                //             color: Colors.blue,
                //           ),
                //         ),
                //       ),
                //   ],
                // );
                if (eventDates != null) {
                  if (eventDates.containsKey(dateKey)) {
                    return Positioned(
                      bottom: 4,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
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
          const SizedBox(
            height: 200,
          ),
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
        ],
      ),
    );
  }
}
