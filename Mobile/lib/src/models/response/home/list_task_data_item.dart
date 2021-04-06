import 'package:Mobile/src/models/response/user_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_task_data_item.g.dart';

@JsonSerializable()
class ListTaskDataItem {
  String id;
  String title;
  String description;
  int priority;
  UserView assignee;
  String status;
  int process;
  String createAt;
  UserView createBy;

  ListTaskDataItem(this.id, this.title, this.description, this.priority,
      this.assignee, this.status, this.process, this.createAt, this.createBy);

  factory ListTaskDataItem.fromJson(Map<String, dynamic> item) =>
      _$ListTaskDataItemFromJson(item);

  Map<String, dynamic> toJson() => _$ListTaskDataItemToJson(this);
}
