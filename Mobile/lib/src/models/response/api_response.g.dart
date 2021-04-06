// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return ApiResponse(
    json['messageCode'] as String,
    json['statusCode'] as int,
    json['data'],
    json['totalRow'] as int,
  );
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'messageCode': instance.messageCode,
      'statusCode': instance.statusCode,
      'data': instance.data,
      'totalRow': instance.totalRow,
    };
