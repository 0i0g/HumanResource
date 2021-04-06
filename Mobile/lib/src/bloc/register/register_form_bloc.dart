import 'package:Mobile/src/models/field/email.dart';
import 'package:Mobile/src/models/field/fullname.dart';
import 'package:Mobile/src/models/field/gender.dart';
import 'package:Mobile/src/models/field/phone_number.dart';
import 'package:Mobile/src/models/field/system_code.dart';
import 'package:Mobile/src/models/request/request_register/request_register.dart';
import 'package:Mobile/src/models/response/api_response.dart';
import 'package:Mobile/src/services/user_service.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  UserService _userService;

  RegisterFormBloc() : super(const RegisterFormState()) {
    this._userService = UserService();
  }

  Future<ActionState> requestRegister() async {
    try {
      ApiResponse res = await _userService.requestRegister(RequestRegister(
          state.email.value,
          state.fullname.value,
          state.phoneNumber.value,
          state.gender.value,
          state.systemCode.value));
      if (res.statusCode == ApiStatusCode.OK) {
        return ActionState(ActionState.Success, '');
      } else if (res.statusCode == ApiStatusCode.BadRequest) {
        if (res.messageCode == SystemMessageConst.CodeNotExist.toString()) {
          return ActionState(ActionState.Failed, 'System Code not found');
        } else if (res.messageCode ==
            UserMessageConst.DuplicateEmail.toString()) {
          return ActionState(ActionState.Failed,
              'Your email has been used to register. Please waiting for accept or contact to your company for more information');
        }
      }
    } catch (e) {}
    return ActionState(ActionState.Error, 'Error');
  }

  @override
  Stream<RegisterFormState> mapEventToState(RegisterFormEvent event) async* {
    if (event is FullnameChanged) {
      final fullname = Fullname.dirty(event.fullname);
      yield state.copyWith(
          fullname: fullname.invalid ? fullname : Fullname.pure(event.fullname),
          status: Formz.validate([
            fullname,
            state.phoneNumber,
            state.gender,
            state.systemCode,
            state.email
          ]));
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
          email: email.invalid ? email : Email.pure(event.email),
          status: Formz.validate([
            email,
            state.phoneNumber,
            state.gender,
            state.systemCode,
            state.fullname
          ]));
    } else if (event is PhoneNumberChanged) {
      final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
      yield state.copyWith(
          phoneNumber: phoneNumber.invalid
              ? phoneNumber
              : PhoneNumber.pure(event.phoneNumber),
          status: Formz.validate([
            phoneNumber,
            state.email,
            state.gender,
            state.systemCode,
            state.fullname
          ]));
    } else if (event is GenderChanged) {
      final gender = Gender.dirty(event.gender);
      yield state.copyWith(
          gender: gender.invalid ? gender : Gender.pure(event.gender),
          status: Formz.validate([
            gender,
            state.email,
            state.phoneNumber,
            state.systemCode,
            state.fullname
          ]));
    } else if (event is SystemCodeChanged) {
      final systemCode = SystemCode.dirty(event.systemCode);
      yield state.copyWith(
          systemCode: systemCode.invalid
              ? systemCode
              : SystemCode.pure(event.systemCode),
          status: Formz.validate([
            systemCode,
            state.email,
            state.gender,
            state.phoneNumber,
            state.fullname
          ]));
    } else if (event is FullnameUnfocused) {
      final fullname = Fullname.dirty(state.fullname.value);
      yield state.copyWith(
          fullname: fullname,
          status: Formz.validate([
            fullname,
            state.phoneNumber,
            state.gender,
            state.systemCode,
            state.email
          ]));
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
          email: email,
          status: Formz.validate([
            email,
            state.phoneNumber,
            state.gender,
            state.systemCode,
            state.fullname
          ]));
    } else if (event is PhoneNumberUnfocused) {
      final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
      yield state.copyWith(
          phoneNumber: phoneNumber,
          status: Formz.validate([
            phoneNumber,
            state.email,
            state.gender,
            state.systemCode,
            state.fullname
          ]));
    } else if (event is GenderUnfocused) {
      final gender = Gender.dirty(state.gender.value);
      yield state.copyWith(
          gender: gender,
          status: Formz.validate([
            gender,
            state.email,
            state.phoneNumber,
            state.systemCode,
            state.fullname
          ]));
    } else if (event is SystemCodeUnfocused) {
      final systemCode = SystemCode.dirty(state.systemCode.value);
      yield state.copyWith(
          systemCode: systemCode,
          status: Formz.validate([
            systemCode,
            state.email,
            state.gender,
            state.phoneNumber,
            state.fullname
          ]));
    } else if (event is FormSubmitted) {
      final email = Email.dirty(state.email.value);
      final fullname = Fullname.dirty(state.fullname.value);
      final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
      final gender = Gender.dirty(state.gender.value);
      final systemCode = SystemCode.dirty(state.systemCode.value);

      yield state.copyWith(
        email: email,
        fullname: fullname,
        phoneNumber: phoneNumber,
        gender: gender,
        systemCode: systemCode,
        status: Formz.validate([
          state.systemCode,
          state.email,
          state.gender,
          state.phoneNumber,
          state.fullname
        ]),
      );
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        var requestState = await requestRegister();
        if (requestState.state == ActionState.Success) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else if (requestState.state == ActionState.Failed) {
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              message: requestState.message);
        } else if (requestState.state == ActionState.Error) {
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              message: requestState.message);
        }
      }
    }
  }
}
