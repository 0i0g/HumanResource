import 'package:Mobile/src/models/response/home/list_task_data_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_task_data.g.dart';

@JsonSerializable()
class ListTaskData {
  List<ListTaskDataItem> items;

  ListTaskData(this.items);

  factory ListTaskData.fromJson(Map<String, dynamic> item) =>
      _$ListTaskDataFromJson(item);

  Map<String, dynamic> toJson() => _$ListTaskDataToJson(this);
}
