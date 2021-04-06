import 'package:json_annotation/json_annotation.dart';

part 'request_register.g.dart';

@JsonSerializable()
class RequestRegister {
  String email;
  String fullname;
  String phoneNumber;
  String gender;
  String systemCode;

  RequestRegister(this.email, this.fullname, this.phoneNumber, this.gender,
      this.systemCode);

  factory RequestRegister.fromJson(Map<String, dynamic> item) =>
      _$RequestRegisterFromJson(item);

  Map<String, dynamic> toJson() => _$RequestRegisterToJson(this);
}
