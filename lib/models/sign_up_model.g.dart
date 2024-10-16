// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpModelImpl _$$SignUpModelImplFromJson(Map<String, dynamic> json) =>
    _$SignUpModelImpl(
      userName: json['userName'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      customerName: json['customerName'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$$SignUpModelImplToJson(_$SignUpModelImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'role': instance.role,
      'customerName': instance.customerName,
      'email': instance.email,
      'mobile': instance.mobile,
    };
