// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileUpdateModel _$UserProfileUpdateModelFromJson(
    Map<String, dynamic> json) {
  return UserProfileUpdateModel(
    json['fullname'] as String,
    json['phoneNumber'] as String,
    json['gender'] as String,
  );
}

Map<String, dynamic> _$UserProfileUpdateModelToJson(
        UserProfileUpdateModel instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
    };
