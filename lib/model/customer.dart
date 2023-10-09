import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer({
    required String id, // doc id
    required String name, // 顧客名
    required int age, // 年齢
    required DateTime date, // 日付
    required String description, // 詳細
    required String imageUrl, // 画像
    Map<DateTime, List>? eventDates, // データを追加した日付を管理
    Map<String, Customer>? eventDetails, // propertiesをまとめたもの
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
