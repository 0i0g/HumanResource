// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_changepassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestChangePassword _$RequestChangePasswordFromJson(
    Map<String, dynamic> json) {
  return RequestChangePassword(
    json['newpassword'] as String,
    json['oldpassword'] as String,
  );
}

Map<String, dynamic> _$RequestChangePasswordToJson(
        RequestChangePassword instance) =>
    <String, dynamic>{
      'oldpassword': instance.oldpassword,
      'newpassword': instance.newpassword,
    };
