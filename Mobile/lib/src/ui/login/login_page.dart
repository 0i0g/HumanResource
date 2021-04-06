import 'package:Mobile/src/bloc/login/login_form_bloc.dart';
import 'package:Mobile/src/ui/components/existable.dart';
import 'package:Mobile/src/ui/login/login_form.dart';
import 'package:Mobile/src/ui/login/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Exitable.onWillPop(context),
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return LoginFormBloc();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF7F9FB), Color(0xFFF7F9FB)])),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  LoginLogo(),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
