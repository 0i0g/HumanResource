// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_task_data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTaskDataItem _$ListTaskDataItemFromJson(Map<String, dynamic> json) {
  return ListTaskDataItem(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String,
    json['priority'] as int,
    json['assignee'] == null
        ? null
        : UserView.fromJson(json['assignee'] as Map<String, dynamic>),
    json['status'] as String,
    json['process'] as int,
    json['createAt'] as String,
    json['createBy'] == null
        ? null
        : UserView.fromJson(json['createBy'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ListTaskDataItemToJson(ListTaskDataItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'assignee': instance.assignee,
      'status': instance.status,
      'process': instance.process,
      'createAt': instance.createAt,
      'createBy': instance.createBy,
    };
