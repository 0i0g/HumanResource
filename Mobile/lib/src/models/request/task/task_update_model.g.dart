// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskUpdateModel _$TaskUpdateModelFromJson(Map<String, dynamic> json) {
  return TaskUpdateModel(
    json['id'] as String,
    json['process'] as int,
  );
}

Map<String, dynamic> _$TaskUpdateModelToJson(TaskUpdateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'process': instance.process,
    };
