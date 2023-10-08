import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewModel/customer_view_model.dart';

class ShowDetailsPage extends ConsumerStatefulWidget {
  const ShowDetailsPage({
    super.key,
    required this.selectedDate,
    this.eventDates,
  });

  final DateTime selectedDate;
  final Map<DateTime, List>? eventDates;

  @override
  ShowDetailsPageState createState() => ShowDetailsPageState();
}

class ShowDetailsPageState extends ConsumerState<ShowDetailsPage> {
  @override
  void initState() {
    debugPrint("Event Details in ShowDetailsPage: ${widget.eventDates}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDayKey = DateTime(widget.selectedDate.year,
        widget.selectedDate.month, widget.selectedDate.day);

    final eventDetails = ref.watch(customerNotifierProvider).eventDetails;

    final eventsForSelectedDate =
        widget.eventDates?[selectedDayKey]?.map((docId) {
              final customer = eventDetails![docId];
              return customer;
            }).toList() ??
            [];

    debugPrint("Events for selected date: $eventsForSelectedDate"); // 追加

    return Scaffold(
      appBar: AppBar(
        title: Text("Details for ${widget.selectedDate.toLocal()}"),
      ),
      body: ListView.builder(
        itemCount: eventsForSelectedDate.length,
        itemBuilder: (context, index) {
          final customer = eventsForSelectedDate[index];

          if (customer == null) {
            return const ListTile(
              title: Text('Unknown'),
            );
          }
          return ListTile(
            title: Text('Name: ${customer.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age: ${customer.age}'),
                Text('Date: ${customer.date.toLocal()}'),
                // 画像のパスを表示（実際のアプリでは画像自体を表示する）
                // for (var imageUrl in customer.images)
                //   Image.network(imageUrl,
                //       height: 100, width: 100), // 画像サイズは適宜調整してください
              ],
            ),
          );
        },
      ),
    );
  }
}
