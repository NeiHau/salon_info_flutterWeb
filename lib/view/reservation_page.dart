import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../common/custom_snackbar.dart';
import '../model/reservation.dart';
import '../viewModel/reservation_view_model.dart';

class ReservationPage extends ConsumerStatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  ReservationPageState createState() => ReservationPageState();
}

class ReservationPageState extends ConsumerState<ReservationPage> {
  DateTime _selectedDate = DateTime.now();
  String _customerName = '';
  late final String customerId; // `late`キーワードを追加

  @override
  void initState() {
    super.initState();
    customerId = Uuid().v4(); // `customerId`の値を`initState`内で設定
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _customerName = value;
                });
              },
              decoration: const InputDecoration(
                labelText: '名前',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text("予約日を選択: ${_selectedDate.toLocal()}"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final reservation = Reservation(
                  customerId: customerId,
                  customerName: _customerName,
                  reservationDate: _selectedDate,
                );
                final result = await ref
                    .read(reservationNotifierProvider.notifier)
                    .createReservation(reservation);

                if (mounted && result) {
                  Navigator.pop(context);
                  CustomSnackbar.showTopSnackBar(context, '予約が完了しました。');
                }
              },
              child: const Text('予約する'),
            ),
          ],
        ),
      ),
    );
  }
}
