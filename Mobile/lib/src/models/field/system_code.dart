import 'package:formz/formz.dart';

enum SystemCodeValidationError { invalid }

class SystemCode extends FormzInput<String, SystemCodeValidationError> {
  const SystemCode.pure([String value = '']) : super.pure(value);
  const SystemCode.dirty([String value = '']) : super.dirty(value);

  static final _systemCodeRegex = RegExp(
    r'^[A-Z0-9]{2,10}$',
  );

  @override
  SystemCodeValidationError validator(String value) {
    return _systemCodeRegex.hasMatch(value)
        ? null
        : SystemCodeValidationError.invalid;
  }
}
