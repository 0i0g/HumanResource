import 'package:formz/formz.dart';

enum FullnameValidationError { invalid }

class Fullname extends FormzInput<String, FullnameValidationError> {
  const Fullname.pure([String value = '']) : super.pure(value);
  const Fullname.dirty([String value = '']) : super.dirty(value);

  @override
  FullnameValidationError validator(String value) {
    return value.length > 0 ? null : FullnameValidationError.invalid;
  }
}
