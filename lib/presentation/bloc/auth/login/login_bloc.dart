import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_event.dart';
import 'package:safetrack/presentation/bloc/auth/login/login_state.dart';
import 'package:safetrack/services/auth_services.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthServices authServices;
  LoginBloc({required this.authServices}) : super(LoginState.initial()) {
    on<LoginButtonPressed>(loginButtonPressed);
    on<LoginEmailChanged>(loginEmailChanged);
    on<LoginPasswordChanged>(loginPasswordChanged);
  }

  FutureOr<void> loginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    log('Login button is clicked');
    emit(state.copyWith(
      loginLoading: true,
      loginFailed: false,
      loginSuccess: false,
    ));
    try {
      if (state.email.isNotEmpty &&
          state.password.isNotEmpty) {
        if (state.isFormValid) {
          await Future.delayed(const Duration(seconds: 1));
          // if (statusCode == 201) {
            
          // } else {
          //   log('$statusCode, $body');
            emit(state.copyWith(
              loginLoading: false,
              loginSuccess: true,
              loginFailed: false,
            ));
          // }
        } else {
          emit(state.copyWith(
            loginLoading: false,
            loginFailed: true,
            loginSuccess: false,
            errorMessage: 'Your form is not valid',
          ));
        }
      } else {
        emit(state.copyWith(
          loginLoading: false,
          loginFailed: true,
          loginSuccess: false,
          errorMessage: 'Fill out the form',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginLoading: false,
        loginFailed: true,
        loginSuccess: false,
        errorMessage: 'Network Error',
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
    emit(state.copyWith(
      password: event.password,
      passwordIsNotEmpty: event.password.isNotEmpty,
      isPasswordValid: validatePassword(event.password),
    ));
  }


  bool validateEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);
    return regex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length > 6;
  }
}
