import 'package:Mobile/src/models/request/task/task_update_model.dart';
import 'package:Mobile/src/models/response/home/list_task_data.dart';
import 'package:Mobile/src/models/response/home/task_info_data.dart';
import 'package:Mobile/src/services/api_client.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:dio/dio.dart';

class TaskService {
  Dio _dio;

  TaskService() {
    _dio = ApiClient.getDio();
  }

  Future<ListTaskData> loadAllTask() async {
    Response res = await _dio.get('/task/listtask');
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200)
        return ListTaskData.fromJson({'items': List.from(res.data['data'])});
    }
    throw Exception();
  }

  Future<TaskInfoData> loadTask(String id) async {
    Response res = await _dio.get('/task', queryParameters: {'taskid': id});
    if (res.statusCode == 200) {
      var statusCode = res.data['statusCode'];
      if (statusCode == 401) throw UnauthorizedException();
      if (statusCode == 200) return TaskInfoData.fromJson(res.data['data']);
    }
    throw Exception();
  }

  Future<bool> updateTask(TaskUpdateModel model) async {
    Response res = await _dio.put('/task',
        data: {'id': model.id, 'process': model.process});
      if (res.statusCode == 200) {
        var statusCode = res.data['statusCode'];
        if (statusCode == 401) throw UnauthorizedException();
        if (statusCode == 200) return true;
      }
    
    throw Exception();
  }
}
