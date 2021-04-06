import 'dart:async';

import 'package:Mobile/src/models/response/home/dashboard.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/services/home_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [HomeLogo(), HomeMenu()],
    );
  }
}

class HomeLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 200,
          ),
        ],
      ),
    );
  }
}

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  Future<Dashboard> _futureDashboard;
  AuthService _authService;
  HomeService _homeService;
  Dashboard _dashboard = Dashboard(0, 2, 0);
  final _colors = [Color(0xFF413F63), Color(0xFFE2A3B6), Color(0xFF20C393)];

  @override
  void initState() {
    _homeService = HomeService();
    _authService = AuthService();
    _futureDashboard = _homeService.loadDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: FutureBuilder(
        future: _futureDashboard,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _dashboard = snapshot.data;
          } else if (snapshot.hasError) {
            if (snapshot.error.runtimeType.toString() ==
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
            }
          }
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                manageTaskItem(_dashboard),
                attendanceItem(_dashboard),
                requestItem(_dashboard),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget manageTaskItem(Dashboard dashborad) {
    bool showChip = false;
    return HomeMenuItem(
        _colors[0],
        Icons.format_list_bulleted_outlined,
        Text(
          'Manage Your Task',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ), () {
      Navigator.of(context).pushNamed('/managetask');
    },
        badge: null,
        chip: getManageTaskChip(),
        showChip: dashborad.totalTask > 0);
  }

  Widget attendanceItem(Dashboard dashborad) {
    return HomeMenuItem(
        _colors[1],
        Icons.calendar_today,
        Text(
          'Manage Your Attendance',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ), () {
      Navigator.pushNamed(context, '/manageattendance');
    },
        badge: getAttendanceBadges(_dashboard),
        chip: Container(),
        showChip: false);
  }

  Widget requestItem(Dashboard dashboard) {
    return HomeMenuItem(
        _colors[2],
        Icons.library_books_outlined,
        Text(
          'Manage Your Request',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ), () {
      Navigator.of(context).pushNamed('/managerequest');
    },
        badge: Container(),
        chip: getRequestChip(dashboard),
        showChip: dashboard.totalWaitingRequest > 0);
  }

  Widget getManageTaskChip() {
    return Text(_dashboard.totalTask.toString(),
        style: TextStyle(
          fontSize: 30,
          color: _colors[0],
        ));
  }

  Widget getAttendanceBadges(Dashboard dashboard) {
    var childred = <Widget>[];
    var now = DateTime.now();
    if (dashboard.checkInCheckOutState == CheckInCheckOutState.None) {
      if (now.hour > WorkingTime.Start ) {
        childred.add(takeBadge("Not check in", 2));
      }
    } else if (dashboard.checkInCheckOutState ==
        CheckInCheckOutState.CheckedIn) {
        childred.add(takeBadge("You are working", 2));
    }
    return Column(children: childred);
  }

  Widget getRequestChip(Dashboard dashboard) {
    return Text(dashboard.totalWaitingRequest.toString(),
        style: TextStyle(
          fontSize: 30,
          color: _colors[0],
        ));
  }
}

class HomeMenuItem extends StatelessWidget {
  final Color background;
  final IconData icon;
  final Text title;
  final void Function() action;
  final Color color = Colors.white;
  final bool showChip;

  Widget chip;
  Widget badge;

  HomeMenuItem(this.background, this.icon, this.title, this.action,
      {this.badge, this.chip, this.showChip}) {
    chip ??= Container();
    badge ??= Container();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: InkWell(
          onTap: action,
          child: Container(
            color: background,
            padding: EdgeInsets.only(top: 15, left: 0, bottom: 15, right: 15),
            child: Badge(
              showBadge: showChip,
              padding: EdgeInsets.all(10),
              badgeColor: Colors.white,
              badgeContent: chip,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: color,
                          size: 60,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: title,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        badge,
                        Positioned.fill(
                          bottom: -50,
                          child: Icon(
                            Icons.arrow_right_alt,
                            size: 100,
                            color: color,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget takeBadge(String title, int type) {
  Color background;
  Color color = Colors.white;
  if (type == 1) {
    background = Color(0xFF198754);
  } else if (type == 2) {
    background = Color(0xFFDC3545);
  } else {
    background = Color(0xFF6C757D);
  }
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    color: background,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
    ),
  );
}
