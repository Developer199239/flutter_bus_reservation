// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusScheduleImpl _$$BusScheduleImplFromJson(Map<String, dynamic> json) =>
    _$BusScheduleImpl(
      scheduleId: (json['scheduleId'] as num?)?.toInt(),
      bus: Bus.fromJson(json['bus'] as Map<String, dynamic>),
      busRoute: BusRoute.fromJson(json['busRoute'] as Map<String, dynamic>),
      departureTime: json['departureTime'] as String,
      ticketPrice: (json['ticketPrice'] as num).toInt(),
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      processingFee: (json['processingFee'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$BusScheduleImplToJson(_$BusScheduleImpl instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'bus': instance.bus,
      'busRoute': instance.busRoute,
      'departureTime': instance.departureTime,
      'ticketPrice': instance.ticketPrice,
      'discount': instance.discount,
      'processingFee': instance.processingFee,
    };
