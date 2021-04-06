// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserView _$UserViewFromJson(Map<String, dynamic> json) {
  return UserView(
    json['id'] as String,
    json['username'] as String,
    json['fullname'] as String,
  );
}

Map<String, dynamic> _$UserViewToJson(UserView instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullname': instance.fullname,
    };
