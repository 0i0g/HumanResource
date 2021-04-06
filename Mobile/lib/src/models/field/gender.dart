import 'package:formz/formz.dart';

enum GenderValidationError { invalid }

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure([String value = '']) : super.pure(value);
  const Gender.dirty([String value = '']) : super.dirty(value);

  @override
  GenderValidationError validator(String value) {
    if  (value == 'male' || value =='female'){
      return null;
    }
    return GenderValidationError.invalid;
  }
}
