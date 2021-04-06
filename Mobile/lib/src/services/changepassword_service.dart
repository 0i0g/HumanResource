import 'package:Mobile/src/models/request/request_changepassword/request_changepassword.dart';
import 'package:Mobile/src/models/request/request_register/request_register.dart';
import 'package:Mobile/src/models/response/api_response.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:dio/dio.dart';

class ChangePasswordService {
  Dio _dio;

  ChangePasswordService() : _dio = Dio() {
    _dio = ApiClient.getDio();
  }

  Future<bool> changePassword(RequestChangePassword request) async {
    Response res =
        await _dio.post('/auth/changepassword', data: request.toJson());
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }
}
