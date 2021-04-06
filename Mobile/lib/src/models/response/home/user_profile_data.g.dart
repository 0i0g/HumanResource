// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) {
  return UserProfileData(
    json['fullname'] as String,
    json['phoneNumber'] as String,
    json['email'] as String,
    json['gender'] as String,
    json['status'] as String,
    json['role'] as int,
    json['isActivated'] as bool,
    json['isDeleted'] as bool,
  );
}

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'gender': instance.gender,
      'status': instance.status,
      'role': instance.role,
      'isDeleted': instance.isDeleted,
      'isActivated': instance.isActivated,
    };
