import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/services/checkint_service.dart';
import 'package:Mobile/src/services/checkout_service.dart';
import 'package:Mobile/src/shared/attendance.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/mcolors.dart';
import 'package:flutter/material.dart';

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  AuthService _authService;
  CheckinService _checkinService;
  CheckoutService _checkoutService;
  Future<Attendance> _attendanceFuture;
  Attendance _attendance;
  @override
  void initState() {
    _checkinService = new CheckinService();
    _checkoutService = new CheckoutService();
    _authService = AuthService();
    _attendanceFuture = _authService.getAttendace();
    _attendance = Attendance(isCheckedIn: true, isCheckedOut: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _attendanceFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _attendance = snapshot.data as Attendance;
          Widget content = Container();
          if (!_attendance.isCheckedIn) {
            content = _takeCheckInButton();
          } else if (_attendance.isCheckedIn && !_attendance.isCheckedOut) {
            content = _takeCheckOutButton();
          } else {
            content = _takeCompletedWork();
          }
          return Center(
            child: content,
          );
        }
        return AlertDialog(content: Text('Error load attendance from storage'));
      },
    );
  }

  Widget _takeCheckInButton() {
    return RaisedButton(
      color: MColors.primary,
      onPressed: () {
        _onCheckIn();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "CHECKIN",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _takeCheckOutButton() {
    return RaisedButton(
      color: MColors.primary,
      onPressed: () {
        _onCheckOut();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "CHECKOUT",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _takeCompletedWork() {
    return Text(Strings.COMPLETED_CHECKIN_CHECKOUT);
  }

  Future<void> _onCheckIn() async {
    _checkinService.checkin().then((success) {
      if (success) {
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
        ).then((_) {
          _attendance.isCheckedIn = true;
          _saveAttendance(CheckInCheckOutState.CheckedIn);
          setState(() {});
        });
      }
      setState(() {});
    });
  }

  Future<void> _onCheckOut() async {
    _checkoutService.checkout().then((success) {
      if (success) {
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
        ).then((_) {
          _attendance.isCheckedOut = true;
          _saveAttendance(CheckInCheckOutState.CheckedOut);
          setState(() {});
        });
      }
      setState(() {});
    });
  }

  Future<void> _saveAttendance(int checkInCheckOutState) async {
    await _authService.saveAttendance(checkInCheckOutState);
  }
}
