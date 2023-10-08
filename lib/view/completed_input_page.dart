import 'package:flutter/material.dart';

import 'calendar_page.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('追加しました'),
            ElevatedButton(
              onPressed: () {
                // CalendarPageに遷移
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarPage(),
                  ),
                );
              },
              child: const Text('ホームページに戻る'),
            ),
          ],
        ),
      ),
    );
  }
}
