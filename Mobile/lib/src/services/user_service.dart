import 'package:Mobile/src/models/request/request_register/request_register.dart';
import 'package:Mobile/src/models/response/api_response.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:dio/dio.dart';

class UserService {
  Dio _dio;

  UserService() : _dio = Dio() {
    _dio = ApiClient.getDio();
  }

  Future<ApiResponse> requestRegister(RequestRegister request) async {
    Response res = await _dio.post(
      '/user/registerrequest',
      data: request.toJson(),
    );
    return ApiResponse.fromJson(res.data);
  }
}
