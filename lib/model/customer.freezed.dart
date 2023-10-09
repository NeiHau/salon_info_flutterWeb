// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  String get id => throw _privateConstructorUsedError; // doc id
  String get name => throw _privateConstructorUsedError; // 顧客名
  int get age => throw _privateConstructorUsedError; // 年齢
  DateTime get date => throw _privateConstructorUsedError; // 日付
  String get description => throw _privateConstructorUsedError; // 詳細
  String get imageUrl => throw _privateConstructorUsedError; // 画像
  Map<DateTime, List>? get eventDates =>
      throw _privateConstructorUsedError; // データを追加した日付を管理
  Map<String, Customer>? get eventDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {String id,
      String name,
      int age,
      DateTime date,
      String description,
      String imageUrl,
      Map<DateTime, List>? eventDates,
      Map<String, Customer>? eventDetails});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? date = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? eventDates = freezed,
    Object? eventDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      eventDates: freezed == eventDates
          ? _value.eventDates
          : eventDates // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>?,
      eventDetails: freezed == eventDetails
          ? _value.eventDetails
          : eventDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, Customer>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int age,
      DateTime date,
      String description,
      String imageUrl,
      Map<DateTime, List>? eventDates,
      Map<String, Customer>? eventDetails});
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? date = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? eventDates = freezed,
    Object? eventDetails = freezed,
  }) {
    return _then(_$CustomerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      eventDates: freezed == eventDates
          ? _value._eventDates
          : eventDates // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>?,
      eventDetails: freezed == eventDetails
          ? _value._eventDetails
          : eventDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, Customer>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl implements _Customer {
  _$CustomerImpl(
      {required this.id,
      required this.name,
      required this.age,
      required this.date,
      required this.description,
      required this.imageUrl,
      final Map<DateTime, List>? eventDates,
      final Map<String, Customer>? eventDetails})
      : _eventDates = eventDates,
        _eventDetails = eventDetails;

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final String id;
// doc id
  @override
  final String name;
// 顧客名
  @override
  final int age;
// 年齢
  @override
  final DateTime date;
// 日付
  @override
  final String description;
// 詳細
  @override
  final String imageUrl;
// 画像
  final Map<DateTime, List>? _eventDates;
// 画像
  @override
  Map<DateTime, List>? get eventDates {
    final value = _eventDates;
    if (value == null) return null;
    if (_eventDates is EqualUnmodifiableMapView) return _eventDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// データを追加した日付を管理
  final Map<String, Customer>? _eventDetails;
// データを追加した日付を管理
  @override
  Map<String, Customer>? get eventDetails {
    final value = _eventDetails;
    if (value == null) return null;
    if (_eventDetails is EqualUnmodifiableMapView) return _eventDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, age: $age, date: $date, description: $description, imageUrl: $imageUrl, eventDates: $eventDates, eventDetails: $eventDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._eventDates, _eventDates) &&
            const DeepCollectionEquality()
                .equals(other._eventDetails, _eventDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      age,
      date,
      description,
      imageUrl,
      const DeepCollectionEquality().hash(_eventDates),
      const DeepCollectionEquality().hash(_eventDetails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer implements Customer {
  factory _Customer(
      {required final String id,
      required final String name,
      required final int age,
      required final DateTime date,
      required final String description,
      required final String imageUrl,
      final Map<DateTime, List>? eventDates,
      final Map<String, Customer>? eventDetails}) = _$CustomerImpl;

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  String get id;
  @override // doc id
  String get name;
  @override // 顧客名
  int get age;
  @override // 年齢
  DateTime get date;
  @override // 日付
  String get description;
  @override // 詳細
  String get imageUrl;
  @override // 画像
  Map<DateTime, List>? get eventDates;
  @override // データを追加した日付を管理
  Map<String, Customer>? get eventDetails;
  @override
  @JsonKey(ignore: true)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
