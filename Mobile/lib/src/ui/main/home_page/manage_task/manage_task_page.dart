import 'dart:async';

import 'package:Mobile/src/models/response/home/list_task_data.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/services/task_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:flutter/material.dart';

class ManageTaskPage extends StatefulWidget {
  @override
  _ManageTaskPageState createState() => _ManageTaskPageState();
}

class _ManageTaskPageState extends State<ManageTaskPage>
    with TickerProviderStateMixin {
  Future<ListTaskData> _listTaskDataFuture;
  TaskService _taskService;
  TabController _tabController;

  @override
  void initState() {
    _taskService = TaskService();
    _listTaskDataFuture = _taskService.loadAllTask();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            textColor: Colors.white,
            child: Icon(Icons.refresh),
            onPressed: _onRefresh,
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _listTaskDataFuture,
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
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    });
                  }

                  run();
                } else if (snapshot.hasData) {
                  return ListTask(
                      snapshot.data, MediaQuery.of(context).size.height);
                }
              }
              return AlertDialog(content: Text(snapshot.error.toString()));
            },
          ),
        ),
      ),
    );
  }

  Widget ListTask(ListTaskData data, double height) {
    var currentUserId = AuthService().currentUserId;

    data.items.sort((a, b) {
      if (a.assignee != b.assignee) {
        if (a.assignee.id == currentUserId) {
          return -1;
        } else {
          return 1;
        }
      }
      return 0;
    });

    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 50,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              25.0,
            ),
            color: Colors.green,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              text: 'Open',
            ),
            Tab(
              text: 'Done',
            ),
            Tab(
              text: 'Resovled',
            ),
          ],
        ),
      ),
      Container(
        height: height - 70,
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView(
                children: data.items
                    .where((x) =>
                        x.status == TaskStatus.Open ||
                        x.status == TaskStatus.ReOpen)
                    .map((item) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/taskinfo',
                      arguments: {'taskId': item.id});
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.teal,
                  elevation: 10,
                  child: ListTile(
                    leading: Text(item.process.toString() + "%"),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title),
                        item.assignee.id == AuthService().currentUserId
                            ? _spanName('ASSIGNED TO YOU')
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
            ListView(
                children: data.items
                    .where((x) => x.status == TaskStatus.ReSolved)
                    .map((item) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/taskinfo',
                      arguments: {'taskId': item.id});
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.teal,
                  elevation: 10,
                  child: ListTile(
                    leading: Text(item.process.toString() + "%"),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title),
                        item.assignee.id == AuthService().currentUserId
                            ? _spanName('ASSIGNED TO YOU')
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
            ListView(
                children: data.items
                    .where((x) => x.status == TaskStatus.Closed)
                    .map((item) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/taskinfo',
                      arguments: {'taskId': item.id});
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.teal,
                  elevation: 10,
                  child: ListTile(
                    leading: Text(item.process.toString() + "%"),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title),
                        item.assignee.id == AuthService().currentUserId
                            ? _spanName('ASSIGNED TO YOU')
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()),
          ],
        ),
      ),
    ]);
  }

  Future<void> _onRefresh() async {
    ListTaskData data = await _taskService.loadAllTask();
    setState(() {
      _listTaskDataFuture = Future.value(data);
    });
  }

  Widget _spanName(String name) {
    return Container(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
          child: Text(
            name,
            style: TextStyle(color: Color(0xFF222222), fontSize: 10),
          ),
        ),
      ),
    );
  }
}
