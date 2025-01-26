import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_event.dart';
import 'package:safetrack/presentation/bloc/features/user_guide/user_guide_state.dart';
import 'package:safetrack/services/storage.dart';

class UserGuideBloc extends Bloc<UserGuideEvent, UserGuideState> {
  UserGuideBloc() : super(UserGuideInitial()) {
    on<UserGuideStatus>(userGuideStatus);
    on<UserGuideCompleteEvent>(userGuideCompleteEvent);
    on<UserGuideResetEvent>(userGuideResetEvent);
  }

  FutureOr<void> userGuideStatus(
      UserGuideStatus event, Emitter<UserGuideState> emit) async {
    final user = await Storage.getData();
    String? id = user['id'];
    try {
      final hasSeenTutorial = await Storage.getField('hasSeenTutorial_$id');
      log('Retrieved: $hasSeenTutorial');
      if (hasSeenTutorial == 'true') {
        log('The user has seen the user guide');
        emit(UserGuideHasSeenState());
      } else {
        log('User ID: $id');
        log('The user has not seen the user guide');
        emit(UserGuideHasntSeenState());
      }
    } catch (e) {
      log('The user guide has problem');
      emit(UserGuideHasntSeenState());
    }
  }

  FutureOr<void> userGuideCompleteEvent(
      UserGuideCompleteEvent event, Emitter<UserGuideState> emit) async {
    final user = await Storage.getData();
    String? id = user['id'];
    try {
      await Storage.saveField('hasSeenTutorial_$id', 'true');
      log('Saving: hasSeenTutorial_$id = true');
      emit(UserGuideHasSeenState());
    } catch (e) {
      log('Error in marking tutorial as seen: $e');
    }
  }

  FutureOr<void> userGuideResetEvent(
      UserGuideResetEvent event, Emitter<UserGuideState> emit) async {
    final user = await Storage.getData();
    String? id = user['id'];
    try {
      await Storage.deleteField('hasSeenTutorial_$id');
      emit(UserGuideHasntSeenState());
    } catch (e) {
      log('Error in resetting tutorial state: $e');
    }
  }
}
