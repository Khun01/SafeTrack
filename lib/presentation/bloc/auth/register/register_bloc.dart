import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/register/register_event.dart';
import 'package:safetrack/presentation/bloc/auth/register/register_state.dart';
import 'package:safetrack/services/auth_services.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthServices authServices;
  RegisterBloc({required this.authServices}) : super(RegisterState.initial()) {
    on<RegisterButtonPressed>(registerButtonPressed);
    on<RegisterNameChanged>(registerNameChanged);
    on<RegisterEmailChanged>(registerEmailChanged);
    on<RegisterPasswordChanged>(registerPasswordChanged);
    on<RegisterConfirmPasswordChanged>(registerConfirmPasswordChanged);
  }

  FutureOr<void> registerButtonPressed(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    log('Register button is clicked');
    emit(state.copyWith(
      registerLoading: true,
      registerFailed: false,
      registerSuccess: false,
    ));

    final response = await authServices.register(
        state.name, state.email, state.password, state.confirmPassword);
    final statusCode = response['statusCode'];
    final body = response['body'];
    try {
      if (state.name.isNotEmpty &&
          state.email.isNotEmpty &&
          state.password.isNotEmpty &&
          state.confirmPassword.isNotEmpty) {
        if (state.isFormValid) {
          if (statusCode == 201) {
            log('$statusCode, $body');
            emit(state.copyWith(
              registerLoading: false,
              registerFailed: false,
              registerSuccess: true,
            ));
          } else {
            log('$statusCode, $body');
            emit(state.copyWith(
              registerLoading: false,
              registerFailed: true,
              registerSuccess: false,
              errorMessage: body,
            ));
          }
        } else {
          emit(state.copyWith(
            registerLoading: false,
            registerFailed: true,
            registerSuccess: false,
            errorMessage: 'Your form is not valid',
          ));
        }
      } else {
        emit(state.copyWith(
          registerLoading: false,
          registerFailed: true,
          registerSuccess: false,
          errorMessage: 'Fill out the form',
        ));
      }
    } catch (e) {
      log('Registering: $statusCode, $body');
      emit(state.copyWith(
        registerLoading: false,
        registerFailed: true,
        registerSuccess: false,
        errorMessage: 'Network Error',
      ));
    }
  }

  void registerNameChanged(
      RegisterNameChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      name: event.name,
      nameIsNotEmpty: event.name.isNotEmpty,
    ));
  }

  void registerEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(
      state.copyWith(
          email: event.email,
          emailIsNotEmpty: event.email.isNotEmpty,
          isEmailValid: validateEmail(event.email)),
    );
  }

  void registerPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      password: event.password,
      passwordIsNotEmpty: event.password.isNotEmpty,
      isPasswordValid: validatePassword(event.password),
    ));
    add(RegisterConfirmPasswordChanged(
      confirmPassword: state.confirmPassword,
    ));
  }

  void registerConfirmPasswordChanged(
      RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      confirmedPasswordIsNotEmpty: event.confirmPassword.isNotEmpty,
      isPasswordEqualToConfirmedPassword:
          passwordIsEqualToConfirmedPassword(event.confirmPassword),
      isConfirmPasswordValid: validateConfirmedPassword(event.confirmPassword),
    ));
  }

  bool validateEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);
    return regex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length > 8;
  }

  bool validateConfirmedPassword(String password) {
    return password.length > 8;
  }

  bool passwordIsEqualToConfirmedPassword(String confirmedPassword) {
    log("Password in bloc: ${state.password}");
    log("Confirmed Password: $confirmedPassword");
    return state.password.trim() == confirmedPassword.trim();
  }
}
