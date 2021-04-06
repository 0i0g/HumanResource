import 'dart:async';

import 'package:Mobile/src/models/response/home/user_profile_data.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/services/user_profile_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  Future<UserProfileData> _futureProfile;
  UserProfileService _userProfileService;

  final select = [
    "Edit Profile",
    "Change Password",
    "Log Out",
  ];

  // @override
  // void initState() {
  //  _userProfileService=new UserProfileService();
  //   _futureProfile = _userProfileService.loadProfile();
  //   super.initState();
  // }

  Widget textfield(UserProfileData userProfileData) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white30,
            filled: true,
            hintText: userProfileData.fullname.toString(),
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  Widget updateProfile() {
    return Container(
      height: 55,
      width: double.infinity,
      child: RaisedButton(
        color: Colors.black54,
        onPressed: () {},
        child: Center(
          child: Text(
            "Update",
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _futureProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
          return Scaffold(
            resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: true,
            body: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SafeArea(
                      child: Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                updateProfile(),
                SizedBox(height: 100),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/changepass');
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.edit),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/changepass');
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.vpn_key),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Change Password",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      var _authService = new AuthService();
                      _authService.logout().then((v) {
                        Navigator.popAndPushNamed(context, '/login');
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Log Out",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
