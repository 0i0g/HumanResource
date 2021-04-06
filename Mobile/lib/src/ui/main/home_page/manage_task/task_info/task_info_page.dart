import 'dart:async';

import 'package:Mobile/src/models/request/task/task_update_model.dart';
import 'package:Mobile/src/models/response/home/task_info_data.dart';
import 'package:Mobile/src/models/response/user_view.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/services/task_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:Mobile/src/utils/mcolors.dart';
import 'package:flutter/material.dart';

part 'task_info_config.dart';
part 'task_info_sections.dart';

class TaskInfoPage extends StatefulWidget {
  TaskInfoPage();
  @override
  _TaskInfoPageState createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {
  TaskService _taskService;
  TaskInfoData _task = TaskInfoData.fromJson({});
  @override
  void initState() {
    _taskService = TaskService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final taskId = arguments['taskId'];
    var sliderSection = takeTaskProgress(null);
    if (taskId == null) return AlertDialog(content: Text('`taskId` is null'));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _taskService.loadTask(taskId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AlertDialog(content: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError &&
                        snapshot.error.runtimeType.toString() ==
                            (UnauthorizedException).toString()) {
                      @override
                      void run() {
                        scheduleMicrotask(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        });
                      }

                      run();
                    } else if (snapshot.hasData) {
                      _task = snapshot.data as TaskInfoData;
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            _takeTaskTitle(_task.title, _task.priority),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child:
                                    _takeUser(_task.createdBy, _task.assignee)),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child:
                                    _takeStatus(_task.createdAt, _task.status)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: _takeTaskContent(_task.description,
                                  MediaQuery.of(context).size.width),
                            ),
                            takeTaskProgress(_task),
                            RaisedButton(
                              onPressed: _task.assignee != null && _task.assignee.id ==
                                              AuthService().currentUserId &&
                                          _task.status == TaskStatus.Open ||
                                      _task.status == TaskStatus.ReOpen
                                  ? () => _onSave(context)
                                  : null,
                              child: Text('SAVE'),
                            )
                          ],
                        ),
                      );
                    }
                  }
                  return AlertDialog(content: Text(snapshot.error.toString()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSave(BuildContext context) async {
    var updateTaskEntry = TaskUpdateModel(_task.id, _task.process);
    try {
      bool isSuccess = await _taskService.updateTask(updateTaskEntry);
      if (isSuccess)
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Success'),
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: MColors.success,
                )
              ],
            ),
          ),
        );

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }
}
