// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerImage _$CustomerImageFromJson(Map<String, dynamic> json) {
  return _CustomerImage.fromJson(json);
}

/// @nodoc
mixin _$CustomerImage {
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerImageCopyWith<CustomerImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerImageCopyWith<$Res> {
  factory $CustomerImageCopyWith(
          CustomerImage value, $Res Function(CustomerImage) then) =
      _$CustomerImageCopyWithImpl<$Res, CustomerImage>;
  @useResult
  $Res call({String imageUrl});
}

/// @nodoc
class _$CustomerImageCopyWithImpl<$Res, $Val extends CustomerImage>
    implements $CustomerImageCopyWith<$Res> {
  _$CustomerImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerImageImplCopyWith<$Res>
    implements $CustomerImageCopyWith<$Res> {
  factory _$$CustomerImageImplCopyWith(
          _$CustomerImageImpl value, $Res Function(_$CustomerImageImpl) then) =
      __$$CustomerImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String imageUrl});
}

/// @nodoc
class __$$CustomerImageImplCopyWithImpl<$Res>
    extends _$CustomerImageCopyWithImpl<$Res, _$CustomerImageImpl>
    implements _$$CustomerImageImplCopyWith<$Res> {
  __$$CustomerImageImplCopyWithImpl(
      _$CustomerImageImpl _value, $Res Function(_$CustomerImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
  }) {
    return _then(_$CustomerImageImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImageImpl implements _CustomerImage {
  _$CustomerImageImpl({required this.imageUrl});

  factory _$CustomerImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImageImplFromJson(json);

  @override
  final String imageUrl;

  @override
  String toString() {
    return 'CustomerImage(imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImageImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImageImplCopyWith<_$CustomerImageImpl> get copyWith =>
      __$$CustomerImageImplCopyWithImpl<_$CustomerImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImageImplToJson(
      this,
    );
  }
}

abstract class _CustomerImage implements CustomerImage {
  factory _CustomerImage({required final String imageUrl}) =
      _$CustomerImageImpl;

  factory _CustomerImage.fromJson(Map<String, dynamic> json) =
      _$CustomerImageImpl.fromJson;

  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$CustomerImageImplCopyWith<_$CustomerImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
