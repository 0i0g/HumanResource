// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRegister _$RequestRegisterFromJson(Map<String, dynamic> json) {
  return RequestRegister(
    json['email'] as String,
    json['fullname'] as String,
    json['phoneNumber'] as String,
    json['gender'] as String,
    json['systemCode'] as String,
  );
}

Map<String, dynamic> _$RequestRegisterToJson(RequestRegister instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullname': instance.fullname,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'systemCode': instance.systemCode,
    };
