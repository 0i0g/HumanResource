import 'dart:async';

import 'package:Mobile/src/models/response/home/attendance_data.dart';
import 'package:Mobile/src/models/response/home/list_attendance_data.dart';
import 'package:Mobile/src/services/attendance_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageAttendance extends StatefulWidget {
  @override
  _ManageAttendanceState createState() => _ManageAttendanceState();
}

class _ManageAttendanceState extends State<ManageAttendance> {
  Future<ListAttendace> _listAttendance;
  AttendanceService _attendanceService;
  @override
  void initState() {
    _attendanceService = new AttendanceService();
    _listAttendance = _attendanceService.loadAllAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _listAttendance,
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
                  return RefreshIndicator(
                    child: ListAttendance(
                        snapshot.data, MediaQuery.of(context).size.height),
                    onRefresh: _onRefresh,
                  );
                }
              }
              return AlertDialog(
                content: Text(snapshot.error.toString()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget ListAttendance(ListAttendace data, double height) {
    return Container(
      height: height,
      child: ListView(
          children: data.items.map((item) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.teal,
          elevation: 10,
          child: ListTile(
            title: Text(item.date.toString()),
            subtitle: Text(item.status.toString()),
          ),
        );
      }).toList()),
    );
  }

  Future<void> _onRefresh() async {
    ListAttendace data = await _attendanceService.loadAllAttendance();
    setState(() {
      _listAttendance = Future.value(data);
    });
  }
}
