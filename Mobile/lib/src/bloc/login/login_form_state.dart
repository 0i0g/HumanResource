part of 'login_form_bloc.dart';

class LoginFormState {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String message;

  const LoginFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.message = ''});

  LoginFormState copyWith(
      {Email email, Password password, FormzStatus status, String message}) {
    return LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
