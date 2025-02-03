import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_event.dart';
import 'package:safetrack/presentation/bloc/profile/user_information/user_information_state.dart';
import 'package:safetrack/services/profile_services.dart';

class UserInformationBloc
    extends Bloc<UserInformationEvent, UserInformationState> {
  final ProfileServices profileServices;
  UserInformationBloc({required this.profileServices})
      : super(UserInformationInitial()) {
    on<GetUserEvent>(getUserEvent);
  }

  FutureOr<void> getUserEvent(
      GetUserEvent event, Emitter<UserInformationState> emit) async {
    emit(UserInformationLoadingState());
    try {
      final user = await profileServices.users();
      emit(UserInformationSuccessState(user: user));
    } catch (e) {
      log('The error in profile information page is: ${e.toString()}');
      emit(UserInformationFailedState(errorMessage: e.toString()));
    }
  }
}
