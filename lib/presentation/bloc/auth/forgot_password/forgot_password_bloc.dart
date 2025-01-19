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
  }

  FutureOr<void> forgotPasswordButtonPressed(ForgotPasswordButtonPressed event,
      Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(
      forgotPasswordFailed: false,
      forgotPasswordLoading: true,
      forgotPasswordSuccess: false,
    ));
    final response = await authServices.forgotPassword(state.email);
    final statuCode = response['statusCode'];
    final body = response['body'];
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (state.email.isNotEmpty) {
        if (state.isFormValid) {
          if (statuCode == 200) {
            emit(state.copyWith(
              forgotPasswordFailed: false,
              forgotPasswordLoading: false,
              forgotPasswordSuccess: true,
            ));
          } else {
            log('Forgot Password: $statuCode, $body');
            emit(state.copyWith(
              forgotPasswordFailed: false,
              forgotPasswordLoading: false,
              forgotPasswordSuccess: false,
              errorMessage: 'Email is not found',
            ));
          }
        } else {
          emit(state.copyWith(
              forgotPasswordFailed: true,
              forgotPasswordLoading: false,
              forgotPasswordSuccess: false,
              errorMessage: 'Invalid Email'));
        }
      } else {
        emit(state.copyWith(
          forgotPasswordFailed: true,
          forgotPasswordLoading: false,
          forgotPasswordSuccess: false,
          errorMessage: 'Enter your email',
        ));
      }
    } catch (e) {
      log('Forgot Password: $statuCode, $body');
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
}
