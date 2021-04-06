import 'package:Mobile/src/bloc/register/register_form_bloc.dart';
import 'package:Mobile/src/ui/register/register_form.dart';
import 'package:Mobile/src/ui/register/register_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterFormBloc(),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF7F9FB),
                Color(0xFFF7F9FB),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [RegisterLogo(), RegisterForm()],
            ),
          ),
        ),
      ),
    );
  }
}
