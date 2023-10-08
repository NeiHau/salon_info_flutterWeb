import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer({
    required String name,
    required int age,
    required DateTime date,
    required String imageUrl,
    Map<DateTime, List>? eventDates,
    Map<String, Customer>? eventDetails,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
