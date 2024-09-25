
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bus_model.freezed.dart';
part 'bus_model.g.dart';
@unfreezed
class Bus with _$Bus{
  factory Bus({
    int? busId,
    required String busName,
    required String busNumber,
    required String busType,
    required int totalSeat,
}) = _Bus;
  factory Bus.fromJson(Map<String, dynamic> json) =>
      _$BusFromJson(json);
}
