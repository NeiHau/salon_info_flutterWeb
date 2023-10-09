import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  // final ImagePicker _picker = ImagePicker();

  Map<String, Customer> eventDetails = {}; // IDとCustomerオブジェクトのマッピング

  String? fileName; // 追加: ファイル名を保持する変数

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

  // 削除メソッド
  Future<bool> deleteCustomer(String docId) async {
    try {
      await customers.doc(docId).delete();
      return true;
    } catch (e) {
      debugPrint('Failed to delete customer: $e');
      return false;
    }
  }
}
