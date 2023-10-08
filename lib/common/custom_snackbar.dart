import 'package:flutter/material.dart';

class CustomSnackbar {
  static OverlayEntry? _overlayEntry;

  static void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    // 既存の_overlayEntryがあれば削除
    _overlayEntry?.remove();

    // 新しいOverlayEntryを作成
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Material(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue,
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Overlayに追加
    overlay.insert(_overlayEntry!);

    // 3秒後に削除
    Future.delayed(const Duration(seconds: 3)).then((value) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}
