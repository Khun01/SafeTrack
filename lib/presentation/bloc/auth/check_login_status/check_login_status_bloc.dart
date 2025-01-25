import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_event.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_state.dart';
import 'package:safetrack/services/storage.dart';

class CheckLoginStatusBloc
    extends Bloc<CheckLoginStatusEvent, CheckLoginStatusState> {
  CheckLoginStatusBloc() : super(CheckLoginStatusInitial()) {
    on<CheckLoginStatusEventToken>(checkLoginStatusEventToken);
  }

  FutureOr<void> checkLoginStatusEventToken(CheckLoginStatusEventToken event,
      Emitter<CheckLoginStatusState> emit) async {
    emit(CheckLoginStatusChecking());
    try {
      final user = await Storage.getData();
      String? token = user['token'];
      await Future.delayed(const Duration(seconds: 2));
      if(token != null){
        log(token);
        emit(CheckLoginStatusLoggedIn());
      }else{
        log('No token');
        emit(CheckLoginStatusLoggedOut());
      }
    } catch (e) {
      log(e.toString());
      emit(CheckLoginStatusFailed(error: e.toString()));
    }
  }
}
