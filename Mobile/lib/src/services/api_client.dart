import 'package:Mobile/src/injector/injector.dart';
import 'package:Mobile/src/shared/shared_preferences_manager.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static Dio getDio()  {
    final Dio _dio = Dio();
    final SharedPreferencesManager _sharedPreferencesManager =
        locator<SharedPreferencesManager>();
    var accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    _dio.interceptors.clear();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers["x-access-token"] = accessToken;
      return options;
    }, onResponse: (Response response) {
      // if (response.data != null &&
      //     response.data['statusCode'] == ApiStatusCode.Unauthorized) {
      //   throw UnauthorizedException();
      // }
      return response;
    }, onError: (DioError error) async {
      print(error.error.toString);
      return error;
    }));
    _dio.options.baseUrl = AppConfig.API_URL;
    _dio.options.headers.addAll({'Content-Type': 'application/json'});
    return _dio;
  }
}
