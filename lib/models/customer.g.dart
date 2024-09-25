// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map<String, dynamic> json) => _$_Customer(
      customerId: json['customerId'] as int?,
      customerName: json['customerName'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'mobile': instance.mobile,
      'email': instance.email,
    };
