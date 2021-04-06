import 'package:Mobile/src/bloc/login/login_form_bloc.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 70 / 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF26A8FF), Color(0xFF407AFF)])),
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
        child: BlocListener<LoginFormBloc, LoginFormState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
            } else if (state.status.isSubmissionSuccess) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          },
          child: Column(
            children: [
              _EmailInput(_emailFocusNode),
              _PasswordInput(_passwordFocusNode),
              _LoginButton(),
              _RegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final FocusNode _focusNode;
  _EmailInput(this._focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Material(
            elevation: 20,
            shadowColor: Colors.blueAccent,
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFF6CA8F1),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) =>
                      context.read<LoginFormBloc>().add(EmailChanged(value)),
                  textInputAction: TextInputAction.next,
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.email.invalid ? Strings.INVALID_EMAIL : '',
                      style: TextStyle(
                          color: Color(0xFFFF9C77),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final FocusNode _focusNode;
  _PasswordInput(this._focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Material(
            elevation: 20,
            shadowColor: Colors.blueAccent,
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFF6CA8F1),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) {
                    context.read<LoginFormBloc>().add(PasswordChanged(value));
                  },
                  textInputAction: TextInputAction.done,
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.password.invalid ? 'Invalid Password' : '',
                      style: TextStyle(
                          color: Color(0xFFFF9C77),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.white,
                disabledColor: Colors.white,
                onPressed: () =>
                    context.read<LoginFormBloc>().add(FormSubmitted()),
              );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        child: Text(
          'REQUEST REGISTER',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: Color(0xFF2D6AF5),
        onPressed: () => Navigator.pushNamed(context, '/register'),
      ),
    );
  }
}
