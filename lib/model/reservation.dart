import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

@freezed
class Reservation with _$Reservation {
  const factory Reservation({
    required String customerId,
    required DateTime reservationDate,
    required String customerName,
    Map<DateTime, List>? reservationList,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
}
