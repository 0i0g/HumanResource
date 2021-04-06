// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceData _$AttendanceDataFromJson(Map<String, dynamic> json) {
  return AttendanceData(
    json['date'] as String,
    json['checkin'] as String,
    json['checkout'] as String,
    json['dayOfWeek'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$AttendanceDataToJson(AttendanceData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'checkin': instance.checkin,
      'checkout': instance.checkout,
      'dayOfWeek': instance.dayOfWeek,
      'status': instance.status,
    };
