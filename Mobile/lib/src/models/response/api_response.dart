import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  String messageCode;
  int statusCode;
  dynamic data;
  int totalRow;

  ApiResponse(this.messageCode, this.statusCode, this.data, this.totalRow);

  factory ApiResponse.fromJson(Map<String, dynamic> item) =>
      _$ApiResponseFromJson(item);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
