import 'package:Mobile/src/injector/injector.dart';
import 'package:Mobile/src/models/request/user_login/user_login.dart';
import 'package:Mobile/src/models/response/api_response.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/shared/attendance.dart';
import 'package:Mobile/src/shared/shared_preferences_manager.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:dio/dio.dart';

class AuthService {
  Dio _dio;

  AuthService() {
    _dio = ApiClient.getDio();
  }

  String get currentUserId {
    final SharedPreferencesManager _sharedPreferencesManager =
        locator<SharedPreferencesManager>();
    return _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyUserId);
  }

  Future<ApiResponse> login(UserLogin user) async {
    final response = await _dio.post(
      '/auth/login',
      data: user.toJson(),
    );

    final resApi = ApiResponse.fromJson(response.data);
    return resApi;
  }

  Future<void> logout() async {
    final SharedPreferencesManager _sharedPreferencesManager =
        locator<SharedPreferencesManager>();
    await _sharedPreferencesManager.clearAll();
  }

  Future<Attendance> getAttendace() async {
    final SharedPreferencesManager _sharedPreferencesManager =
        locator<SharedPreferencesManager>();

    var isCheckedIn = _sharedPreferencesManager
        .getBool(SharedPreferencesManager.keyIsCheckedIn);

    var isCheckedOut = _sharedPreferencesManager
        .getBool(SharedPreferencesManager.keyIsCheckedOut);

    return Attendance(
        isCheckedIn: isCheckedIn ?? false, isCheckedOut: isCheckedOut ?? false);
  }

  Future<void> saveAttendance(int checkInCheckOutState) async {
    var now = DateTime.now();
    var attendance = Attendance(isCheckedIn: true, isCheckedOut: true);
    if (checkInCheckOutState == CheckInCheckOutState.None) {
      attendance.isCheckedIn = false;
      attendance.isCheckedOut = false;
    } else if (checkInCheckOutState == CheckInCheckOutState.CheckedIn) {
      attendance.isCheckedIn = true;
      attendance.isCheckedOut = false;
    } else {
      attendance.isCheckedIn = true;
      attendance.isCheckedOut = true;
    }

    final SharedPreferencesManager _sharedPreferencesManager =
        locator<SharedPreferencesManager>();
    await _sharedPreferencesManager.putBool(
        SharedPreferencesManager.keyIsCheckedIn, attendance.isCheckedIn);
    await _sharedPreferencesManager.putBool(
        SharedPreferencesManager.keyIsCheckedOut, attendance.isCheckedIn);
  }
}
