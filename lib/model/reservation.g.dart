// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      customerId: json['customerId'] as String,
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      customerName: json['customerName'] as String,
      reservationList: (json['reservationList'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(DateTime.parse(k), e as List<dynamic>),
      ),
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'reservationDate': instance.reservationDate.toIso8601String(),
      'customerName': instance.customerName,
      'reservationList': instance.reservationList
          ?.map((k, e) => MapEntry(k.toIso8601String(), e)),
    };
