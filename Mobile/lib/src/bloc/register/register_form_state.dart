part of 'register_form_bloc.dart';

class RegisterFormState {
  final Fullname fullname;
  final PhoneNumber phoneNumber;
  final Gender gender;
  final Email email;
  final SystemCode systemCode;
  final String message;
  final FormzStatus status;

  const RegisterFormState(
      {this.email = const Email.pure(),
      this.fullname = const Fullname.pure(),
      this.phoneNumber = const PhoneNumber.pure(),
      this.gender = const Gender.pure(),
      this.systemCode = const SystemCode.pure(),
      this.status = FormzStatus.pure,
      this.message = ''});

  RegisterFormState copyWith(
      {Email email,
      Fullname fullname,
      PhoneNumber phoneNumber,
      Gender gender,
      SystemCode systemCode,
      FormzStatus status,
      String message}) {
    return RegisterFormState(
        email: email ?? this.email,
        fullname: fullname ?? this.fullname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        gender: gender ?? this.gender,
        systemCode: systemCode ?? this.systemCode,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
