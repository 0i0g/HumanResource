// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_task_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTaskData _$ListTaskDataFromJson(Map<String, dynamic> json) {
  return ListTaskData(
    (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : ListTaskDataItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListTaskDataToJson(ListTaskData instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
