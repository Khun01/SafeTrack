import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/verification/verification_event.dart';
import 'package:safetrack/presentation/bloc/auth/verification/verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<VerificationButtonPressed>(verificationButtonPressed);
    on<VerificationTokenChangedEvent>(verificationTokenChangedEvent);
  }

  List<String> tokens = List.filled(6, '');

  FutureOr<void> verificationButtonPressed(
      VerificationButtonPressed event, Emitter<VerificationState> emit) async {
    log('The verification button is clicked');
    final token = tokens.join('');
    try {
      emit(VerificationLoadingState());
      if (token.isNotEmpty) {
        log('The token is: $token');
        emit(VerificationSuccessState(token: token));
      } else {
        emit(VerificationFailedState(error: 'Token cannot be empty'));
      }
    } catch (e) {
      emit(VerificationFailedState(error: e.toString()));
    }
  }

  FutureOr<void> verificationTokenChangedEvent(
      VerificationTokenChangedEvent event, Emitter<VerificationState> emit) {
    final index = event.index;
    if (index >= 0 && index < tokens.length) {
      tokens[index] = event.token;
      log('Token at index $index updated to ${event.token}');
    }
  }
}
