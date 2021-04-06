import 'package:json_annotation/json_annotation.dart';

part 'user_profile_update_model.g.dart';

@JsonSerializable()
class UserProfileUpdateModel {
  String fullname;
  String phoneNumber;
  String gender;

  UserProfileUpdateModel(this.fullname,this.phoneNumber,this.gender);

  factory UserProfileUpdateModel.fromJson(Map<String, dynamic> item) =>
      _$UserProfileUpdateModelFromJson(item);

  Map<String, dynamic> toJson() => _$UserProfileUpdateModelToJson(this);
}
