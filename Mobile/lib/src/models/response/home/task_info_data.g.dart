// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInfoData _$TaskInfoDataFromJson(Map<String, dynamic> json) {
  return TaskInfoData(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String,
    json['priority'] as int,
    json['assignee'] == null
        ? null
        : UserView.fromJson(json['assignee'] as Map<String, dynamic>),
    json['status'] as String,
    json['process'] as int,
    json['createdAt'] as String,
    json['createdBy'] == null
        ? null
        : UserView.fromJson(json['createdBy'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TaskInfoDataToJson(TaskInfoData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'assignee': instance.assignee,
      'status': instance.status,
      'process': instance.process,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
    };
