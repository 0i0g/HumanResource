import 'package:Mobile/src/models/response/user_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_info_data.g.dart';

@JsonSerializable()
class TaskInfoData {
  String id;
  String title;
  String description;
  int priority;
  UserView assignee;
  String status;
  int process;
  String createdAt;
  UserView createdBy;

  TaskInfoData(this.id, this.title, this.description, this.priority,
      this.assignee, this.status, this.process, this.createdAt, this.createdBy);

  factory TaskInfoData.fromJson(Map<String, dynamic> item) =>
      _$TaskInfoDataFromJson(item);

  Map<String, dynamic> toJson() => _$TaskInfoDataToJson(this);
}
