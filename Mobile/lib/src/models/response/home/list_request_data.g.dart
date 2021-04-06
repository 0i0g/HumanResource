// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequestData _$ListRequestDataFromJson(Map<String, dynamic> json) {
  return ListRequestData(
    (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : ListRequestDataItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListRequestDataToJson(ListRequestData instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
