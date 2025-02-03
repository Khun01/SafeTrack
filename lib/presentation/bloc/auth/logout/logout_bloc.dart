import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_event.dart';
import 'package:safetrack/presentation/bloc/auth/logout/logout_state.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/storage.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthServices authServices;
  LogoutBloc({required this.authServices}) : super(LogoutInitial()) {
    on<LogoutButtonClickedEvent>(logoutButtonClickedEvent);
  }

  FutureOr<void> logoutButtonClickedEvent(LogoutButtonClickedEvent event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    try {
      final response = await authServices.logout();
      if (response['statusCode'] == 200) {
        await Storage.deleteData();
        emit(LogoutSuccessfully());
      } else {
        emit(LogoutFailed(error: response['data']['message']));
      }
    } catch (e) {
      emit(LogoutFailed(error: e.toString()));
    }
  }
}
