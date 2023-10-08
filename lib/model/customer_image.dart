import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_image.freezed.dart';
part 'customer_image.g.dart';

@freezed
class CustomerImage with _$CustomerImage {
  factory CustomerImage({
    required String imageUrl,
  }) = _CustomerImage;

  factory CustomerImage.fromJson(Map<String, dynamic> json) =>
      _$CustomerImageFromJson(json);
}
