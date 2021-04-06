import 'package:Mobile/src/models/response/home/list_request_data.dart';
import 'package:Mobile/src/models/response/home/list_request_data_item.dart';
import 'package:Mobile/src/models/response/user_view.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:Mobile/src/utils/format.dart';
import 'package:dio/dio.dart';

class RequestService {
  Dio _dio;

  RequestService() {
    _dio = ApiClient.getDio();
  }

  Future<ListRequestData> loadAllRequest() async {
    return await Future.wait(
        [_dio.get("/ot/listot"), _dio.get("/dayoff/listdayoff")]).then((reses) {
      if (reses[0].statusCode != 200 || reses[1].statusCode != 200)
        throw Exception();
      if (reses[0].data['statusCode'] == 401 ||
          reses[1].data['statusCode'] == 401) throw UnauthorizedException();
      if (reses[0].data['statusCode'] == 200 &&
          reses[1].data['statusCode'] == 200) {
        var ot = (reses[0].data['data'] as List<dynamic>)
            .map((value) => ListRequestDataItem(
                value['requestId'],
                UserView.fromJson(value['user']),
                value['fromDate'],
                value['toDate'],
                value['status'],
                RequestType.OTRequest,
                value['timeOT']))
            .toList();

        var dayoff = (reses[1].data['data'] as List<dynamic>)
            .map((value) => ListRequestDataItem(
                value['requestId'],
                UserView.fromJson(value['user']),
                value['fromDate'],
                value['toDate'],
                value['status'],
                RequestType.DayOffRequest,
                0))
            .toList();
        ot.addAll(dayoff);
        var reqs = ot.map((value) {
          Map<String, dynamic> entry = value.toJson();
          entry['user'] = value.user.toJson();
          return entry;
        });

        return ListRequestData.fromJson({'items': List.from(reqs)});
      }
    }).catchError((err) => throw Exception(err));
  }

  Future<bool> deleteOTRequest(String id) async {
    Response res = await _dio
        .put('/ot', data: {'requestId': id, 'status': RequestStatus.CANCELED});
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }

  Future<bool> deleteDayOffRequest(String id) async {
    Response res = await _dio.put('/dayoff',
        data: {'requestId': id, 'status': RequestStatus.CANCELED});
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }

  Future<bool> sendOTRequest(
      DateTime formDate, DateTime toDate, int timeOT) async {
    Response res = await _dio.post('/ot', data: {
      'timeot': timeOT,
      'fromdate': DateTimeFormat(formDate).toRequestFormat(),
      'todate': DateTimeFormat(toDate).toRequestFormat()
    });
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }

  Future<bool> sendDayOffRequest(DateTime formDate, DateTime toDate) async {
    Response res = await _dio.post('/dayoff', data: {
      'fromdate': DateTimeFormat(formDate).toRequestFormat(),
      'todate': DateTimeFormat(toDate).toRequestFormat()
    });
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return true;
    }
    return false;
  }
}
