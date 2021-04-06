import 'dart:async';

import 'package:Mobile/src/models/request/request_changepassword/request_changepassword.dart';
import 'package:Mobile/src/models/request/user/user_profile_update_model.dart';
import 'package:Mobile/src/models/response/home/user_profile_data.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/services/changepassword_service.dart';
import 'package:Mobile/src/services/user_profile_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:Mobile/src/utils/mcolors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  UserProfileUpdateModel _userUpdateModel;
  // UserProfileUpdateModel _userUpdateModelDraft;
  UserProfileData _user;
  Future<UserProfileData> _userFuture;
  UserProfileService _userProfileService;
  GenderCharacter _gender = GenderCharacter.empty;

  @override
  void initState() {
    _userUpdateModel = UserProfileUpdateModel('', '', '');
    // _userUpdateModelDraft = UserProfileUpdateModel('', '', '');
    _userProfileService = UserProfileService();
    _userFuture = _userProfileService.loadProfile();
    _user = UserProfileData('', '', '', '', '', 3, true, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _userFuture,
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
                      _user = snapshot.data as UserProfileData;
                      _gender = _user.gender == 'male'
                          ? GenderCharacter.male
                          : GenderCharacter.female;
                      _userUpdateModel.fullname = _user.fullname;
                      _userUpdateModel.phoneNumber = _user.phoneNumber;
                      _userUpdateModel.gender = _user.gender;
                      return _takeFormProfile();
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

  Widget _takeFormProfile() {
    TextStyle style1 = TextStyle();
    TextStyle style2 = TextStyle(fontSize: 25);
    return Column(
      children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Name: '),
                    ),
                    _isEditing
                        ? _takeFullnameTextField()
                        : Text(
                            _user.fullname,
                            style: style2,
                          ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Phone: '),
                    ),
                    _isEditing
                        ? _takePhoneTextField()
                        : Text(
                            _user.phoneNumber,
                            style: style2,
                          ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Gender: '),
                    ),
                    _isEditing
                        ? _takeGenderField()
                        : Text(
                            _user.gender,
                            style: style2,
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isEditing ? _takeButtonCancel() : Container(),
            _isEditing ? _takeButtonSave() : Container(),
            !_isEditing ? _takeButtonEdit() : Container(),
          ],
        ),
        _takeButtonChangePassword(),
        _takeLogoutButton()
      ],
    );
  }

  Widget _takeFullnameTextField() {
    return Expanded(
      child: TextFormField(
        initialValue: _user.fullname,
        keyboardType: TextInputType.name,
        maxLines: 1,
        onChanged: (value) => _userUpdateModel.fullname = value,
      ),
    );
  }

  Widget _takePhoneTextField() {
    return Expanded(
      child: TextFormField(
        initialValue: _user.phoneNumber,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        onChanged: (value) => _userUpdateModel.phoneNumber = value,
      ),
    );
  }

  Widget _takeGenderField() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Radio<GenderCharacter>(
        activeColor: MColors.primary,
        value: GenderCharacter.female,
        groupValue: _gender,
        onChanged: (value) {
          setState(() {
            _user.gender = value.toShortString();
            _userUpdateModel.gender = _user.gender;
          });
        },
      ),
      Container(
          margin: EdgeInsets.only(right: 60),
          child: Text(
            'female',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          )),
      Radio<GenderCharacter>(
        activeColor: MColors.primary,
        value: GenderCharacter.male,
        groupValue: _gender,
        onChanged: (value) {
          print(_user.gender);
          setState(() {
            _user.gender = value.toShortString();
            _userUpdateModel.gender = _user.gender;
          });
        },
      ),
      Text('male',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _takeButtonEdit() {
    return Container(
      width: 300,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isEditing = true;
          });
        },
        child: Text('Edit'),
      ),
    );
  }

  Widget _takeButtonCancel() {
    return Container(
      margin: EdgeInsets.all(8),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isEditing = false;
          });
        },
        child: Text('Cancel'),
      ),
    );
  }

  Widget _takeButtonSave() {
    return Container(
      margin: EdgeInsets.all(8),
      child: RaisedButton(
        color: MColors.success,
        onPressed: () {
          // _userUpdateModel = _userUpdateModelDraft;
          _onSave(_userUpdateModel);
        },
        child: Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _onSave(UserProfileUpdateModel model) async {
    bool isSuccess = await _userProfileService.updateProfile(model);
    if (isSuccess) {
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
      ).then((v) {
        _onRefresh();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Invalid value'),
              Icon(
                Icons.error_outline_rounded,
                color: MColors.danger,
              )
            ],
          ),
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    UserProfileData userProfile = await _userProfileService.loadProfile();
    _isEditing = false;
    setState(() {
      _user = userProfile;
    });
  }

  Widget _takeButtonChangePassword() {
    return Container(
      width: 300,
      child: RaisedButton(
        onPressed: () => _onChangePassword(),
        child: Text('Change Password'),
      ),
    );
  }

  void _onChangePassword() {
    showDialog(
        context: context, builder: (context) => _takeDialogChangePassword());
  }

  Widget _takeDialogChangePassword() {
    String newPassword = '';
    String oldPassword = '';
    return AlertDialog(
      content: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Old password'),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              oldPassword = value;
            },
          ),
          Text('New password'),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              newPassword = value;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    _onchangePassword(oldPassword, newPassword);
                  },
                  child: Text('Save'),
                ),
              )
            ],
          )
        ],
      )),
    );
  }

  Future<void> _onchangePassword(String oldPassword, String newPassword) async {
    ChangePasswordService _changePasswordService = ChangePasswordService();
    bool isSuccess = await _changePasswordService
        .changePassword(RequestChangePassword(newPassword, oldPassword));
    if (isSuccess) {
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
      ).then((v) {
        Navigator.pop(context);
        _onRefresh();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Old password incorrect'),
              Icon(
                Icons.error_outline_rounded,
                color: MColors.danger,
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _takeLogoutButton() {
    return Container(
      width: 300,
      child: RaisedButton(
        onPressed: () {
          var _authService = new AuthService();
          _authService.logout().then((v) {
            Navigator.popAndPushNamed(context, '/login');
          });
        },
        child: Text('Logout'),
      ),
    );
  }
}
