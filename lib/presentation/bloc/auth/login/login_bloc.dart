import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_event.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_state.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthServices authServices;
  LoginBloc({required this.authServices}) : super(LoginState.initial()) {
    on<LoginButtonPressed>(loginButtonPressed);
    on<LoginEmailChanged>(loginEmailChanged);
    on<LoginPasswordChanged>(loginPasswordChanged);
    on<LoginFailedReset>(loginFailedReset);
  }

  FutureOr<void> loginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (state.email.isNotEmpty && state.password.isNotEmpty) {
      if (state.isFormValid) {
        try {
          emit(state.copyWith(loginLoading: true, loginSuccess: false));
          final response = await authServices.login(
            state.email,
            state.password,
          );
          final statusCode = response['statusCode'];
          final responseData = response['data'];
          if (statusCode == 200) {
            final String id = responseData['id'].toString();
            final String token = responseData['token'];
            await Storage.saveData(id: id, token: token);
            log('$id, $token');
            emit(state.copyWith(
                loginFailed: false,
                loginLoading: false,
                loginSuccess: true,
                submitting: false));
          } else if (statusCode == 401) {
            emit(state.copyWith(
              loginLoading: false,
              loginFailed: true,
              loginSuccess: false,
              errorMessage: 'The provided credentials are incorrect.',
            ));
          } else {
            log('The error in logging in is: ${response['data']['message']}');
            emit(state.copyWith(
              loginLoading: false,
              loginFailed: true,
              loginSuccess: false,
              errorMessage: 'Network Error',
            ));
          }
        } catch (e) {
          log('Unexpected error: ${e.toString()}');
          emit(state.copyWith(
            loginLoading: false,
            loginFailed: true,
            errorMessage: 'An unexpected error occurred.',
          ));
        }
      } else {
        emit(state.copyWith(
          isEmailValid: state.emailIsNotEmpty && state.isEmailValid,
          isPasswordValid: state.passwordIsNotEmpty && state.isPasswordValid,
        ));
      }
    } else {
      emit(state.copyWith(
        errorMessage: 'Fill out the form',
      ));
    }
  }

  void loginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
        emailIsNotEmpty: event.email.isNotEmpty,
        isEmailValid: validateEmail(event.email),
      ),
    );
  }

  void loginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
        passwordIsNotEmpty: event.password.isNotEmpty,
        isPasswordValid: validatePassword(event.password),
      ),
    );
  }

  bool validateEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);
    return regex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length > 8;
  }

  FutureOr<void> loginFailedReset(
      LoginFailedReset event, Emitter<LoginState> emit) {
    emit(state.copyWith(loginFailed: false));
  }
}
