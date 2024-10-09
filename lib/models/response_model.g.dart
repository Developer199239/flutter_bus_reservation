// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseModelImpl _$$ResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$ResponseModelImpl(
      responseStatus: $enumDecodeNullable(
              _$ResponseStatusEnumMap, json['responseStatus']) ??
          ResponseStatus.SAVED,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 200,
      message: json['message'] as String? ?? 'Saved',
      object: json['object'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ResponseModelImplToJson(_$ResponseModelImpl instance) =>
    <String, dynamic>{
      'responseStatus': _$ResponseStatusEnumMap[instance.responseStatus]!,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'object': instance.object,
    };

const _$ResponseStatusEnumMap = {
  ResponseStatus.SAVED: 'SAVED',
  ResponseStatus.FAILED: 'FAILED',
  ResponseStatus.UNAUTHORIZED: 'UNAUTHORIZED',
  ResponseStatus.AUTHORIZED: 'AUTHORIZED',
  ResponseStatus.EXPIRED: 'EXPIRED',
  ResponseStatus.NONE: 'NONE',
};
