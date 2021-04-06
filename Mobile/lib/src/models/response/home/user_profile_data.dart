import 'package:Mobile/src/models/response/home/attendance_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_data.g.dart';

@JsonSerializable()
class UserProfileData {
  String fullname, phoneNumber, email;
  String gender;
  String status;
  int role;
  bool isDeleted;
  bool isActivated;

  UserProfileData(this.fullname, this.phoneNumber, this.email, this.gender,
      this.status, this.role, this.isActivated, this.isDeleted);

  factory UserProfileData.fromJson(Map<String, dynamic> item) =>
      _$UserProfileDataFromJson(item);

  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);
}
