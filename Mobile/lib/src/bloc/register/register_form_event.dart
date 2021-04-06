part of 'register_form_bloc.dart';

abstract class RegisterFormEvent{
  const RegisterFormEvent();

  List<Object> get values => [];
}

class FullnameUnfocused extends RegisterFormEvent {}

class FullnameChanged extends RegisterFormEvent{
  const FullnameChanged(this.fullname);

  final String fullname;

  @override
  List<Object> get values => [fullname];
}

class PhoneNumberUnfocused extends RegisterFormEvent {}

class PhoneNumberChanged extends RegisterFormEvent {
  const PhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get values => [phoneNumber];
}

class EmailUnfocused extends RegisterFormEvent {}

class EmailChanged extends RegisterFormEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get values => [email];
}

class SystemCodeUnfocused extends RegisterFormEvent {}

class SystemCodeChanged extends RegisterFormEvent {
  const SystemCodeChanged(this.systemCode);

  final String systemCode;

  @override
  List<Object> get values => [systemCode];
}

class GenderUnfocused extends RegisterFormEvent {}

class GenderChanged extends RegisterFormEvent {
  const GenderChanged(this.gender);

  final String gender;

  @override
  List<Object> get values => [gender];
}

class FormSubmitted extends RegisterFormEvent {}