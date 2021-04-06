import 'package:Mobile/src/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:Mobile/src/utils/error.dart';

class CheckoutService {
  Dio _dio;

  CheckoutService() : _dio = Dio() {
    _dio = ApiClient.getDio();
  }
  Future<bool> checkout() async {
    Response res = await _dio.post('/attendance/checkout');
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }
}
