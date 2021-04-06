// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_attendance_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAttendace _$ListAttendaceFromJson(Map<String, dynamic> json) {
  return ListAttendace(
    (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : AttendanceData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListAttendaceToJson(ListAttendace instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
