import 'package:json_annotation/json_annotation.dart';

part 'request_changepassword.g.dart';

@JsonSerializable()
class RequestChangePassword {
  String oldpassword, newpassword;

  RequestChangePassword(this.newpassword, this.oldpassword);
  factory RequestChangePassword.fromJson(Map<String, dynamic> item) =>
      _$RequestChangePasswordFromJson(item);

  Map<String, dynamic> toJson() => _$RequestChangePasswordToJson(this);
}
