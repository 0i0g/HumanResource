import 'package:json_annotation/json_annotation.dart';

part 'user_view.g.dart';

@JsonSerializable()
class UserView {
  String id;
  String username;
  String fullname;

  UserView(this.id, this.username, this.fullname);

  factory UserView.fromJson(Map<String, dynamic> item) =>
      _$UserViewFromJson(item);

  Map<String, dynamic> toJson() => _$UserViewToJson(this);
}
