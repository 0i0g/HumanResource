import 'package:json_annotation/json_annotation.dart';

part 'user_login.g.dart';

@JsonSerializable()
class UserLogin {
  String username;
  String password;

  UserLogin(this.username,  this.password);

  factory UserLogin.fromJson(Map<String, dynamic> item) =>
      _$UserLoginFromJson(item);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}
