
import 'package:bus_reservation/models/user_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_schedule.dart';
import 'user_info_model.dart';
part 'bus_reservation.freezed.dart';
part 'bus_reservation.g.dart';
@unfreezed
class BusReservation with _$BusReservation{
  factory BusReservation({
    int? reservationId,
    required UserInfoModel appUser,
    required BusSchedule busSchedule,
    required int timestamp,
    required String departureDate,
    required int totalSeatBooked,
    required String seatNumbers,
    required String reservationStatus,
    required int totalPrice,
}) = _BusReservation;

  factory BusReservation.fromJson(Map<String, dynamic> json) =>
      _$BusReservationFromJson(json);
}