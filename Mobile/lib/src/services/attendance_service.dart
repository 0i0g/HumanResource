import 'package:Mobile/src/models/response/home/attendance_data.dart';
import 'package:Mobile/src/models/response/home/dashboard.dart';
import 'package:Mobile/src/models/response/home/list_attendance_data.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:dio/dio.dart';

class AttendanceService {
  Dio _dio;

  AttendanceService() {
    _dio = ApiClient.getDio();
  }

  Future<ListAttendace> loadAllAttendance() async {
    Response res = await _dio.get('/attendance?fromnow=0');
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) {
        var data = (res.data['data'] as List).map(
          (e) => {AttendanceData.fromJson(e).checkin},
        );
      }
      return ListAttendace.fromJson(
        {
          'items': List.from(
            res.data['data'],
          ),
        },
      );
    }
    throw Exception();
  }
}
