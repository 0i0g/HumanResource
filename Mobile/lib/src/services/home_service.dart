import 'package:Mobile/src/models/response/home/dashboard.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/shared/attendance.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:dio/dio.dart';

class HomeService {
  Dio _dio;
  AuthService _authService;

  HomeService() {
    _dio = ApiClient.getDio();
    _authService = AuthService();
  }

  Future<Dashboard> loadDashboard() async {
    Response res = await _dio.get('/dashboard/mobile');
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) {
        var data = Dashboard.fromJson(res.data['data']);
        // save attendance
        await _authService.saveAttendance(data.checkInCheckOutState);
        return data;
      }
    }
    throw Exception();
  }
}
