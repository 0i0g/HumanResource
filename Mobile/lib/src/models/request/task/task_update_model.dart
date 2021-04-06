import 'package:json_annotation/json_annotation.dart';

part 'task_update_model.g.dart';

@JsonSerializable()
class TaskUpdateModel {
  String id;
  int process;

  TaskUpdateModel(this.id,  this.process);

  factory TaskUpdateModel.fromJson(Map<String, dynamic> item) =>
      _$TaskUpdateModelFromJson(item);

  Map<String, dynamic> toJson() => _$TaskUpdateModelToJson(this);
}
