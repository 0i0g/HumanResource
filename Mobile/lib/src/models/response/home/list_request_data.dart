import 'package:Mobile/src/models/response/home/list_request_data_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_request_data.g.dart';

@JsonSerializable()
class ListRequestData {
  List<ListRequestDataItem> items;

  ListRequestData(this.items);

  factory ListRequestData.fromJson(Map<String, dynamic> item) =>
      _$ListRequestDataFromJson(item);

  Map<String, dynamic> toJson() => _$ListRequestDataToJson(this);
}
