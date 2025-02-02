import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_event.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_state.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/storage.dart';

class CheckLoginStatusBloc
    extends Bloc<CheckLoginStatusEvent, CheckLoginStatusState> {
      final AuthServices authServices;
  CheckLoginStatusBloc({required this.authServices}) : super(CheckLoginStatusInitial()) {
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
        final response = await authServices.checkToken(token);
        if(response['statusCode'] == 200){
          emit(CheckLoginStatusLoggedIn());
        }else{
          log('The message foe checking token is: ${response['statusCode']}, ${response['data']['message']}}');
          emit(CheckLoginStatusLoggedOut());
        }
      }else{
        log('No token');
        emit(CheckLoginStatusLoggedOut());
      }
    } catch (e) {
      log(e.toString());
      emit(CheckLoginStatusFailed(error: 'Please check your internet connection.'));
    }
  }
}
