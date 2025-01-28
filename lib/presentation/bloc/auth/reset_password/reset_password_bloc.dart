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
    on<ResetPasswordFailedReset>(resetPasswordFailedReset);
    on<ResetPasswordSuccessReset>(resetPasswordSuccessReset);
  }

  FutureOr<void> resetPasswordButtonPressed(
    ResetPasswordButtonPressed event,
    Emitter<ResetPasswordState> emit,
  ) async {
    log('ResetPassword event: email=${event.email}, token=${event.token}, '
        'password=${state.password}, confirmPassword=${state.confirmPassword}');

    emit(state.copyWith(
      resetPasswordLoading: true,
      resetPasswordFailed: false,
      resetPasswordSuccess: false,
      errorMessage: null,
    ));

    try {
      if (state.password.isEmpty || state.confirmPassword.isEmpty) {
        emit(state.copyWith(
          resetPasswordLoading: false,
          resetPasswordFailed: true,
          resetPasswordSuccess: false,
          errorMessage: 'Password fields cannot be empty.',
        ));
        return;
      }

      if (!state.isFormValid) {
        emit(state.copyWith(
          resetPasswordLoading: false,
          resetPasswordFailed: true,
          resetPasswordSuccess: false,
          errorMessage: 'Password confirmation does not match.',
        ));
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      final response = await authServices.resetPassword(
        event.email,
        event.token,
        state.password,
        state.confirmPassword,
      );

      final statusCode = response['statusCode'];
      final body = response['body'];

      if (statusCode == 200) {
        emit(state.copyWith(
          resetPasswordLoading: false,
          resetPasswordFailed: false,
          resetPasswordSuccess: true,
          successMessage: 'Password reset successfully'
        ));
      } else {
        log('Reset Password failed: statusCode=$statusCode, body=$body');
        emit(state.copyWith(
          resetPasswordLoading: false,
          resetPasswordFailed: true,
          resetPasswordSuccess: false,
          errorMessage: body['message'] ?? 'Reset password failed.',
        ));
      }
    } catch (error, stackTrace) {
      log('Reset Password error: $error', error: error, stackTrace: stackTrace);
      emit(state.copyWith(
        resetPasswordLoading: false,
        resetPasswordFailed: true,
        resetPasswordSuccess: false,
        errorMessage: 'Network error occurred. Please try again.',
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

  FutureOr<void> resetPasswordFailedReset(
      ResetPasswordFailedReset event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(
      resetPasswordFailed: false,
      password: '',
      confirmPassword: '',
    ));
  }

  FutureOr<void> resetPasswordSuccessReset(ResetPasswordSuccessReset event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(
      resetPasswordSuccess: false,
      password: '',
      confirmPassword: '',
    ));
  }
}
