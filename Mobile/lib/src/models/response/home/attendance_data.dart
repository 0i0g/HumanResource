import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_data.g.dart';

@JsonSerializable()
class AttendanceData {
  String date, checkin, checkout;
  String dayOfWeek;
  String status;

  AttendanceData(
      this.date, this.checkin, this.checkout, this.dayOfWeek, this.status);

  factory AttendanceData.fromJson(Map<String, dynamic> item) =>
      _$AttendanceDataFromJson(item);

  Map<String, dynamic> toJson() => _$AttendanceDataToJson(this);
}
