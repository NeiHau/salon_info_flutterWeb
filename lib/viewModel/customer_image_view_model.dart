import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/customer_image.dart';

final customerImageNotifierProvider =
    StateNotifierProvider<CustomerImageNotifier, CustomerImage>((ref) {
  return CustomerImageNotifier();
});

class CustomerImageNotifier extends StateNotifier<CustomerImage> {
  CustomerImageNotifier() : super(CustomerImage(imageUrl: ''));

  String? fileName; // 追加: ファイル名を保持する変数

  // 新しいフィールドとメソッドを追加
  void setImageUrl(String url) {
    state = state.copyWith(imageUrl: url);
  }

  // 写真取得。
  void getImage() {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    input.onChange.listen((e) {
      final file = input.files!.first;
      fileName = file.name; // ファイル名を取得し、変数に保持
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        setImageUrl(reader.result as String); // Data URL
      });

      reader.readAsDataUrl(file);
    });
  }

  // Firebase Storageに保存
  Future<void> saveImageToFirebaseStorage() async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child(fileName ?? "default_name.jpg"); // 保持しているファイル名を使用

      final String dataUrl = state.imageUrl;
      final RegExp regex = RegExp(r'data:image/(.*);base64,');
      final String base64String = dataUrl.replaceFirst(regex, '');
      final Uint8List uint8ListData = base64Decode(base64String);

      final UploadTask uploadTask = storageRef.putData(uint8ListData);

      await uploadTask.whenComplete(() async {
        final String downloadUrl = await storageRef.getDownloadURL();
        debugPrint("Image uploaded, download URL: $downloadUrl");
      });
    } catch (e) {
      debugPrint("Failed to upload image: $e");
    }
  }
}
