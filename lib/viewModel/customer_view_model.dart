import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

import '../model/customer.dart';

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, Customer>((ref) {
  return CustomerNotifier();
});

class CustomerNotifier extends StateNotifier<Customer> {
  CustomerNotifier() : super(Customer(name: '', age: 0, date: DateTime.now()));

  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  final ImagePicker _picker = ImagePicker();

  Map<String, Customer> eventDetails = {}; // IDとCustomerオブジェクトのマッピング

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  // void addImage(String image) {
  //   state = state.copyWith(images: [...state.images, image]);
  // }

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

  // Future<void> pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     addImage(pickedFile.path);
  //   }
  // }
  // Future<void> pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final String downloadURL = await uploadImageToFirebase(pickedFile.path);
  //     addImage(downloadURL);
  //   }
  // }

  Future<void> saveCustomer() async {
    try {
      await customers.add({
        'name': state.name,
        'age': state.age,
        'date': state.date,
        //'images': state.images,
      });
      debugPrint("Successfully Customer Added");
    } catch (e) {
      debugPrint("Failed to add customer: $e");
    }
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
            name: data['name'],
            age: data['age'],
            date: date,
            //images: List<String>.from(data['images']),
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
}
