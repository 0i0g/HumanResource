// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_request_data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequestDataItem _$ListRequestDataItemFromJson(Map<String, dynamic> json) {
  return ListRequestDataItem(
    json['requestId'] as String,
    json['user'] == null
        ? null
        : UserView.fromJson(json['user'] as Map<String, dynamic>),
    json['fromDate'] as String,
    json['toDate'] as String,
    json['status'] as String,
    json['type'] as String,
    json['timeOT'] as int,
  );
}

Map<String, dynamic> _$ListRequestDataItemToJson(
        ListRequestDataItem instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'user': instance.user,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'status': instance.status,
      'type': instance.type,
      'timeOT': instance.timeOT,
    };
