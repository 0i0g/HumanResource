// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return Dashboard(
    json['totalTask'] as int,
    json['checkInCheckOutState'] as int,
    json['totalWaitingRequest'] as int,
  );
}

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'totalTask': instance.totalTask,
      'checkInCheckOutState': instance.checkInCheckOutState,
      'totalWaitingRequest': instance.totalWaitingRequest,
    };
