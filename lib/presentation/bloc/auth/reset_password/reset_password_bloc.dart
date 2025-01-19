import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_event.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_state.dart';
import 'package:safetrack/services/auth_services.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthServices authServices;
  ResetPasswordBloc({required this.authServices})
      : super(ResetPasswordState.initial()) {
    on<ResetPasswordButtonPressed>(resetPasswordButtonPressed);
    on<ResetPasswordChanged>(resetPasswordChanged);
    on<ResetConfirmPasswordChanged>(resetConfirmPasswordChanged);
  }

  FutureOr<void> resetPasswordButtonPressed(ResetPasswordButtonPressed event,
      Emitter<ResetPasswordState> emit) async {
    log('${event.email}, ${event.token}, ${state.password}, ${state.confirmPassword}');
    emit(state.copyWith(
      resetPasswordLoading: true,
      resetPasswordFailed: false,
      resetPasswordSuccess: false,
    ));
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (state.password.isNotEmpty && state.confirmPassword.isNotEmpty) {
        if (state.isFormValid) {
          final response = await authServices.resetPassword(
              event.email, event.token, state.password, state.confirmPassword);
          final statuCode = response['statusCode'];
          final body = response['body'];
          if (statuCode == 200) {
            emit(state.copyWith(
              resetPasswordLoading: false,
              resetPasswordFailed: false,
              resetPasswordSuccess: true,
            ));
          } else {
            log('Reset Password: $statuCode, $body');
            emit(state.copyWith(
              resetPasswordLoading: false,
              resetPasswordFailed: true,
              resetPasswordSuccess: false,
              errorMessage: 'Email is not found',
            ));
          }
        }
      } else {
        emit(state.copyWith(
          resetPasswordLoading: false,
          resetPasswordFailed: true,
          resetPasswordSuccess: false,
          errorMessage: 'Put your new password',
        ));
      }
    } catch (e) {
      log('Reset Password: $e');
      emit(state.copyWith(
        resetPasswordLoading: false,
        resetPasswordFailed: true,
        resetPasswordSuccess: false,
        errorMessage: 'Network Error',
      ));
    }
  }

  void resetPasswordChanged(
      ResetPasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(
      password: event.password,
      passwordIsNotEmpty: event.password.isNotEmpty,
      isPasswordValid: validatePassword(event.password),
    ));
    add(ResetConfirmPasswordChanged(
      confirmPassword: state.confirmPassword,
    ));
  }

  void resetConfirmPasswordChanged(
      ResetConfirmPasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      confirmPasswordIsNotEmpty: event.confirmPassword.isNotEmpty,
      isPasswordEqualToConfirmedPassword:
          passwordIsEqualToConfirmedPassword(event.confirmPassword),
      isConfirmPasswordValid: validateConfirmedPassword(event.confirmPassword),
    ));
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
