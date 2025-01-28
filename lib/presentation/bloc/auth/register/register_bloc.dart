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
    on<RegisterFailedReset>(registerFailedReset);
  }

  FutureOr<void> registerButtonPressed(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    log('Register button is clicked');

    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      emit(state.copyWith(
        registerLoading: false,
        registerFailed: true,
        registerSuccess: false,
        errorMessage: 'Fill out all the fields before submitting',
      ));
      return; 
    }

    if (!state.isFormValid) {
      emit(state.copyWith(
        registerLoading: false,
        registerFailed: true,
        registerSuccess: false,
        errorMessage: 'Please correct the errors in the form',
      ));
      return; 
    }

    emit(state.copyWith(
      registerLoading: true,
      registerFailed: false,
      registerSuccess: false,
    ));

    await Future.delayed(const Duration(seconds: 2));
    final response = await authServices.register(
        state.name, state.email, state.password, state.confirmPassword);
    final statusCode = response['statusCode'];
    final body = response['body'];

    try {
      if (statusCode == 201) {
        log('the registration is success: $statusCode, $body');
        emit(state.copyWith(
            registerLoading: false,
            registerFailed: false,
            registerSuccess: true,
            successMessage: 'Registration Completed'));
      } else if (statusCode == 500) {
        emit(state.copyWith(
          registerLoading: false,
          registerFailed: true,
          registerSuccess: false,
          errorMessage: 'Network Error',
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

  FutureOr<void> registerFailedReset(
      RegisterFailedReset event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      registerFailed: false,
      email: '',
      name: '',
      password: '',
      confirmPassword: '',
    ));
  }
}
