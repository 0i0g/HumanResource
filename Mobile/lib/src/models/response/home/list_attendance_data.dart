import 'package:Mobile/src/models/response/home/attendance_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_attendance_data.g.dart';

@JsonSerializable()
class ListAttendace {
  List<AttendanceData> items;

  ListAttendace(this.items);

  factory ListAttendace.fromJson(Map<String, dynamic> item) =>
      _$ListAttendaceFromJson(item);

  Map<String, dynamic> toJson() => _$ListAttendaceToJson(this);
}
