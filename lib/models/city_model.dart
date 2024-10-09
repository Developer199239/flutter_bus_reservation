
import 'package:freezed_annotation/freezed_annotation.dart';
part 'city_model.freezed.dart';
part 'city_model.g.dart';
@unfreezed
class City with _$City{
  factory City({
    int? cityId,
    required String cityName,
}) = _City;
  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);
}
