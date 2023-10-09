// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      customerId: json['customerId'] as String,
      reservationDate: DateTime.parse(json['reservationDate'] as String),
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'reservationDate': instance.reservationDate.toIso8601String(),
    };
