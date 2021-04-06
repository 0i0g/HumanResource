import 'package:json_annotation/json_annotation.dart';

part 'dashboard.g.dart';

@JsonSerializable()
class Dashboard {
  int totalTask;
  int checkInCheckOutState;
  int totalWaitingRequest;

  Dashboard(
      this.totalTask, this.checkInCheckOutState, this.totalWaitingRequest);

  factory Dashboard.fromJson(Map<String, dynamic> item) =>
      _$DashboardFromJson(item);

  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}
