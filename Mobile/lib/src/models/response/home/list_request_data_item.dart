import 'package:Mobile/src/models/response/user_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_request_data_item.g.dart';

@JsonSerializable()
class ListRequestDataItem {
  String requestId;
  UserView user;
  String fromDate;
  String toDate;
  String status;
  String type;
  int timeOT;

  ListRequestDataItem(this.requestId, this.user, this.fromDate, this.toDate,
      this.status, this.type, this.timeOT);

  factory ListRequestDataItem.fromJson(Map<String, dynamic> item) =>
      _$ListRequestDataItemFromJson(item);

  Map<String, dynamic> toJson() => _$ListRequestDataItemToJson(this);
}
