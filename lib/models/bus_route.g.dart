// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusRouteImpl _$$BusRouteImplFromJson(Map<String, dynamic> json) =>
    _$BusRouteImpl(
      routeId: (json['routeId'] as num?)?.toInt(),
      routeName: json['routeName'] as String,
      cityFrom: json['cityFrom'] as String,
      cityTo: json['cityTo'] as String,
      distanceInKm: (json['distanceInKm'] as num).toDouble(),
    );

Map<String, dynamic> _$$BusRouteImplToJson(_$BusRouteImpl instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'routeName': instance.routeName,
      'cityFrom': instance.cityFrom,
      'cityTo': instance.cityTo,
      'distanceInKm': instance.distanceInKm,
    };
