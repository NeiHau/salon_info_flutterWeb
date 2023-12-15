import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../model/customer.dart';

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, Customer>((ref) {
  return CustomerNotifier();
});

class CustomerNotifier extends StateNotifier<Customer> {
  CustomerNotifier()
      : super(
          Customer(
            name: '',
            age: 0,
            date: DateTime.now(),
            description: '',
            imageUrl: '',
            id: '',
          ),
        );

  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Map<String, Customer> eventDetails = {}; // IDとCustomerオブジェクトのマッピング

  String? fileName; // ファイル名を保持

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setImageUrl(String url) {
    state = state.copyWith(imageUrl: url);
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (date != null) {
      setDate(date);
    }
  }

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

  // 画像のURLを取得
  // Future<String?> getDownloadUrl(String filePath) async {
  //   try {
  //     // Firebase Storageのインスタンスを取得
  //     final FirebaseStorage storage = FirebaseStorage.instance;
  //
  //     // 特定のファイルの参照を取得
  //     final Reference ref = storage.ref(filePath);
  //
  //     // ダウンロードURLを取得
  //     final String downloadUrl = await ref.getDownloadURL();
  //
  //     return downloadUrl;
  //   } catch (e) {
  //     logger.log(Level.trace, e);
  //     return null;
  //   }
  // }

  Future<bool> saveCustomer() async {
    try {
      await customers.add({
        'name': state.name,
        'age': state.age,
        'date': state.date,
        'description': state.description,
        'imageUrl': state.imageUrl,
      });
      debugPrint("Successfully Customer Added");
      return true;
    } catch (e) {
      debugPrint("Failed to add customer: $e");
      return false;
    }
  }

  // Firebase Storageに画像データを保存
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
        setImageUrl(downloadUrl); // ダウンロードURLを設定
      });
    } catch (e) {
      debugPrint("Failed to upload image: $e");
    }
  }

  // 絞り込み検索
  Future<List<Customer>> fetchFilteredCustomers(String name) async {
    List<Customer> filteredCustomerList = [];

    try {
      final QuerySnapshot snapshot = await customers.get();
      for (var doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final DateTime date = (data['date'] as Timestamp).toDate();
        final customer = Customer(
          id: doc.id,
          name: data['name'],
          age: data['age'],
          date: date,
          description: data['description'].toString(),
          imageUrl: data['imageUrl'].toString(),
        );

        if (name.isEmpty || customer.name.contains(name)) {
          filteredCustomerList.add(customer);
        }
      }
    } catch (e) {
      debugPrint("Failed to fetch all customers: $e");
    }

    return filteredCustomerList;
  }

  // 一覧取得
  Future<List<Customer>> fetchAllCustomers() async {
    List<Customer> customerList = [];

    try {
      final QuerySnapshot snapshot = await customers.get();
      for (var doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final DateTime date = (data['date'] as Timestamp).toDate();
        final customer = Customer(
          id: doc.id,
          name: data['name'],
          age: data['age'],
          date: date,
          description: data['description'].toString(),
          imageUrl: data['imageUrl'].toString(),
        );

        customerList.add(customer);
      }
    } catch (e) {
      debugPrint("Failed to fetch all customers: $e");
    }

    return customerList;
  }

  // カレンダーの日付と同じデータを取得
  Future<void> fetchDates() async {
    try {
      final QuerySnapshot snapshot = await customers.get();
      final Map<DateTime, List<String>> newEventDates = {};
      for (var doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('date')) {
          final DateTime date = (data['date'] as Timestamp).toDate();
          final DateTime dateKey = DateTime(date.year, date.month, date.day);
          final customer = Customer(
            id: doc.id.toString(),
            name: data['name'],
            age: data['age'],
            date: date,
            description: data['description'].toString(),
            imageUrl: data['imageUrl'].toString(),
          );

          debugPrint(
              "Setting customer for docId ${doc.id}: ${customer.name}"); // 追加

          eventDetails[doc.id] = customer;
          state = state.copyWith(eventDetails: eventDetails);
          if (newEventDates.containsKey(dateKey)) {
            newEventDates[dateKey]!.add(doc.id);
          } else {
            newEventDates[dateKey] = [doc.id];
          }
        }
      }
      state = state.copyWith(eventDates: newEventDates);
    } catch (e) {
      debugPrint("Failed to fetch dates: $e");
    }
  }

  // データ削除
  Future<bool> deleteCustomer(String docId) async {
    try {
      await customers.doc(docId).delete();
      return true;
    } catch (e) {
      debugPrint('Failed to delete customer: $e');
      return false;
    }
  }

  void setupNotification() {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 通知が来たときの処理
    });
  }
}
