part of 'login_form_bloc.dart';

abstract class LoginFormEvent{
  const LoginFormEvent();

  List<Object> get values => [];
}

class EmailUnfocused extends LoginFormEvent {}

class EmailChanged extends LoginFormEvent{
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get values => [email];
}

class PasswordUnfocused extends LoginFormEvent {}

class PasswordChanged extends LoginFormEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get values => [password];
}

class FormSubmitted extends LoginFormEvent {}