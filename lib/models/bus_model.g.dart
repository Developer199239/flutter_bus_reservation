// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusImpl _$$BusImplFromJson(Map<String, dynamic> json) => _$BusImpl(
      busId: (json['busId'] as num?)?.toInt(),
      busName: json['busName'] as String,
      busNumber: json['busNumber'] as String,
      busType: json['busType'] as String,
      totalSeat: (json['totalSeat'] as num).toInt(),
    );

Map<String, dynamic> _$$BusImplToJson(_$BusImpl instance) => <String, dynamic>{
      'busId': instance.busId,
      'busName': instance.busName,
      'busNumber': instance.busNumber,
      'busType': instance.busType,
      'totalSeat': instance.totalSeat,
    };
