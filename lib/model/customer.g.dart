// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      name: json['name'] as String,
      age: json['age'] as int,
      date: DateTime.parse(json['date'] as String),
      eventDates: (json['eventDates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(DateTime.parse(k), e as List<dynamic>),
      ),
      eventDetails: (json['eventDetails'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Customer.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'date': instance.date.toIso8601String(),
      'eventDates':
          instance.eventDates?.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'eventDetails': instance.eventDetails,
    };
