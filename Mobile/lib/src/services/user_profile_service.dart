import 'package:Mobile/src/models/request/user/user_profile_update_model.dart';
import 'package:Mobile/src/models/response/home/attendance_data.dart';
import 'package:Mobile/src/models/response/home/dashboard.dart';
import 'package:Mobile/src/models/response/home/list_attendance_data.dart';
import 'package:Mobile/src/models/response/home/user_profile_data.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:dio/dio.dart';

class UserProfileService {
  Dio _dio;

  UserProfileService() {
    _dio = ApiClient.getDio();
  }

  Future<UserProfileData> loadProfile() async {
    Response res = await _dio.get('/user/profile');
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) {
        return UserProfileData.fromJson(res.data['data']);
      }
    }
    throw Exception();
  }

  Future<bool> updateProfile(UserProfileUpdateModel model) async {
    Response res = await _dio.put('/user', data: {
      'fullname': model.fullname,
      'phonenumber': model.phoneNumber,
      'gender': model.gender
    });
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }
}
