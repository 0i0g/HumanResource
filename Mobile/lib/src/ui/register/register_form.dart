import 'package:Mobile/src/bloc/register/register_form_bloc.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatelessWidget {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _fullnameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _systemCodeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 80 / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF26A8FF),
            Color(0xFF407AFF),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
        child: BlocListener<RegisterFormBloc, RegisterFormState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
            } else if (state.status.isSubmissionSuccess) {
              showDialog(context: context, builder: (_) => _SuccessDialog());
            }
          },
          child: Column(
            children: [
              _SystemCodeInput(_systemCodeFocusNode),
              _EmailInput(_emailFocusNode),
              _FullnameInput(_fullnameFocusNode),
              _PhoneNumberInput(_phoneNumberFocusNode),
              _GenderInput(_genderFocusNode),
              _RegisterButton(),
              _BackToLoginButton()
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
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
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
                      context.read<RegisterFormBloc>().add(EmailChanged(value)),
                  textInputAction: TextInputAction.next,
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.email.invalid
                          ? Strings.INVALID_EMAIL
                          : Strings.EMPTY,
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

class _FullnameInput extends StatelessWidget {
  final FocusNode _focusNode;
  _FullnameInput(this._focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.fullname != current.fullname,
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
                    hintText: 'Fullname',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) => context
                      .read<RegisterFormBloc>()
                      .add(FullnameChanged(value)),
                  textInputAction: TextInputAction.next,
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.fullname.invalid
                          ? Strings.INVALID_FULLNAME
                          : Strings.EMPTY,
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

class _PhoneNumberInput extends StatelessWidget {
  final FocusNode _focusNode;
  _PhoneNumberInput(this._focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
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
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) => context
                      .read<RegisterFormBloc>()
                      .add(PhoneNumberChanged(value)),
                  textInputAction: TextInputAction.next,
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.phoneNumber.invalid
                          ? Strings.INVALID_PHONENUMBER
                          : Strings.EMPTY,
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

class _SystemCodeInput extends StatelessWidget {
  final FocusNode _focusNode;
  _SystemCodeInput(this._focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) =>
          previous.systemCode != current.systemCode,
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
                    hintText: 'System Code',
                    hintStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                  onChanged: (value) => context
                      .read<RegisterFormBloc>()
                      .add(SystemCodeChanged(value)),
                  textInputAction: TextInputAction.next,
                ),
                Positioned.fill(
                  bottom: -20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      state.systemCode.invalid
                          ? Strings.INVALID_SYSTEMCODE
                          : Strings.EMPTY,
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

class _GenderInput extends StatelessWidget {
  final FocusNode _focusNode;
  GenderCharacter _gender = GenderCharacter.empty;

  _GenderInput(this._focusNode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return BlocListener<RegisterFormBloc, RegisterFormState>(
          listener: (context, state) {
            _gender = state.gender.value == 'male'
                ? GenderCharacter.male
                : state.gender.value == 'female'
                    ? GenderCharacter.female
                    : GenderCharacter.empty;
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<GenderCharacter>(
                          activeColor: Colors.white,
                          value: GenderCharacter.female,
                          groupValue: _gender,
                          onChanged: (value) {
                            context
                                .read<RegisterFormBloc>()
                                .add(GenderChanged(value.toShortString()));
                          },
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 60),
                            child: Text(
                              'female',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        Radio<GenderCharacter>(
                          activeColor: Colors.white,
                          value: GenderCharacter.male,
                          groupValue: _gender,
                          onChanged: (value) {
                            context
                                .read<RegisterFormBloc>()
                                .add(GenderChanged(value.toShortString()));
                          },
                        ),
                        Text('male',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                      state.gender.invalid
                          ? Strings.PLEASE_SELECT_GENDER
                          : Strings.EMPTY,
                      style: TextStyle(
                          color: Color(0xFFFF9C77),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.white,
                disabledColor: Colors.white,
                onPressed: () =>
                    context.read<RegisterFormBloc>().add(FormSubmitted()),
              );
      },
    );
  }
}

class _BackToLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        child: Text(
          'Back To Login',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        color: Color(0xFF2D6AF5),
        onPressed: () =>
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false),
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        Strings.SUCCESS,
        style: TextStyle(color: Colors.greenAccent),
      ),
      content: Text(Strings.REGISTER_SUCCESS_MESSAGE),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
          },
        )
      ],
    );
  }
}
