import 'package:Mobile/src/injector/injector.dart';
import 'package:Mobile/src/models/field/email.dart';
import 'package:Mobile/src/models/field/password.dart';
import 'package:Mobile/src/models/request/user_login/user_login.dart';
import 'package:Mobile/src/models/response/api_response.dart';
import 'package:Mobile/src/services/auth_service.dart';
import 'package:Mobile/src/shared/shared_preferences_manager.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  AuthService _authService;

  LoginFormBloc() : super(const LoginFormState()) {
    this._authService = AuthService();
  }

  Future<ActionState> login() async {
    try {
      ApiResponse res = await _authService
          .login(UserLogin(state.email.value, state.password.value));
      if (res.statusCode == ApiStatusCode.OK) {
        await saveToken(
            res.data["_id"], res.data["accessToken"], res.data["refreshToken"]);
        return ActionState(ActionState.Success, '');
      } else if (res.statusCode == ApiStatusCode.NotFound) {
        if (res.messageCode == UserMessageConst.PleaseActiveUser) {
          return ActionState(ActionState.Failed, 'Your account is not active');
        } else if (res.messageCode == UserMessageConst.UserDeleted) {
          return ActionState(
              ActionState.Failed, 'Your account has been deleted');
        } else if (res.messageCode == UserMessageConst.SystemDeleted) {
          return ActionState(ActionState.Failed, 'Email or Password incorrect');
        } else {
          return ActionState(ActionState.Failed, 'Email or Password incorrect');
        }
      }
    } catch (e) {}
    return ActionState(ActionState.Error, 'Error');
  }

  @override
  Stream<LoginFormState> mapEventToState(LoginFormEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
          email: email.invalid ? email : Email.pure(event.email),
          status: Formz.validate([email, state.password]));
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.invalid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      );
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        var loginState = await login();
        if (loginState.state == ActionState.Success) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else if (loginState.state == ActionState.Failed) {
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              message: loginState.message);
        } else if (loginState.state == ActionState.Error) {
          yield state.copyWith(
              status: FormzStatus.submissionFailure,
              message: loginState.message);
        }
      }
    }
  }
}

Future<void> saveToken(
    String _id, String accessToken, String refreshToken) async {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();
  await _sharedPreferencesManager.saveToken(_id, accessToken, refreshToken);
}
