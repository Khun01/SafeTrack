import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_event.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_state.dart';
import 'package:safetrack/services/auth_services.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthServices authServices;
  ForgotPasswordBloc({required this.authServices})
      : super(ForgotPasswordState.initial()) {
    on<ForgotPasswordButtonPressed>(forgotPasswordButtonPressed);
    on<ForgotPasswordEmailChanged>(forgotPasswordEmailChanged);
    on<ForgotPasswordFailedReset>(forgotPasswordFailedReset);
    on<ForgotPasswordSuccessReset>(forgotPasswordSuccessReset);
  }

  FutureOr<void> forgotPasswordButtonPressed(ForgotPasswordButtonPressed event,
      Emitter<ForgotPasswordState> emit) async {
    log('Register button is clicked');

    if (state.email.isEmpty) {
      emit(state.copyWith(
        forgotPasswordFailed: true,
        forgotPasswordLoading: false,
        forgotPasswordSuccess: false,
        errorMessage: 'Enter your email',
      ));
      return;
    }

    if (!state.isFormValid) {
      emit(state.copyWith(
        forgotPasswordFailed: true,
        forgotPasswordLoading: false,
        forgotPasswordSuccess: false,
        errorMessage: 'Please correct the errors in the form',
      ));
      return;
    }

    emit(state.copyWith(
      forgotPasswordFailed: false,
      forgotPasswordLoading: true,
      forgotPasswordSuccess: false,
    ));

    final response = await authServices.forgotPassword(state.email);
    final statusCode = response['statusCode'];
    final body = response['body'];

    try {
      if (statusCode == 200) {
        log('the registration is success: $statusCode, $body');
        emit(state.copyWith(
          forgotPasswordFailed: false,
          forgotPasswordLoading: false,
          forgotPasswordSuccess: true,
          successMessage: 'A verification code was sent to your email.',
        ));
      } else if (statusCode == 500) {
        emit(state.copyWith(
          forgotPasswordFailed: true,
          forgotPasswordLoading: false,
          forgotPasswordSuccess: false,
          errorMessage: 'Network Error',
        ));
      } else {
        log('$statusCode, $body');
        emit(state.copyWith(
          forgotPasswordFailed: true,
          forgotPasswordLoading: false,
          forgotPasswordSuccess: false,
          errorMessage: 'Email is not found',
        ));
      }
    } catch (e) {
      log('Registering: $statusCode, $body');
      emit(state.copyWith(
        forgotPasswordFailed: true,
        forgotPasswordLoading: false,
        forgotPasswordSuccess: false,
        errorMessage: 'Network Error',
      ));
    }
  }

  void forgotPasswordEmailChanged(
      ForgotPasswordEmailChanged event, Emitter<ForgotPasswordState> emit) {
    emit(
      state.copyWith(
        email: event.email,
        emailIsNotEmpty: event.email.isNotEmpty,
        isEmailValid: validateEmail(event.email),
      ),
    );
  }

  bool validateEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);
    return regex.hasMatch(email);
  }

  FutureOr<void> forgotPasswordFailedReset(
      ForgotPasswordFailedReset event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      forgotPasswordFailed: false,
      email: '',
    ));
  }

  FutureOr<void> forgotPasswordSuccessReset(ForgotPasswordSuccessReset event, Emitter<ForgotPasswordState> emit) {
     emit(state.copyWith(
      forgotPasswordSuccess: false,
      email: '',
    ));
  }
}
