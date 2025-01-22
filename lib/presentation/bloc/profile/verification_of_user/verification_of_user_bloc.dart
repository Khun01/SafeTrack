import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/profile/verification_of_user/verification_of_user_event.dart';
import 'package:safetrack/presentation/bloc/profile/verification_of_user/verification_of_user_state.dart';
import 'package:safetrack/services/profile_services.dart';

class VerificationOfUserBloc
    extends Bloc<VerificationOfUserEvent, VerificationOfUserState> {
  final ProfileServices profileServices;
  VerificationOfUserBloc({required this.profileServices})
      : super(VerificationOfUserInitial()) {
    on<VerificationOfUserClickedButtonEvent>(
        verificationOfUserClickedButtonEvent);
  }

  FutureOr<void> verificationOfUserClickedButtonEvent(
      VerificationOfUserClickedButtonEvent event,
      Emitter<VerificationOfUserState> emit) async {
    log('The submit button for verification for user is clicked');
    emit(VerificationOfUserLoading());
    final inputValues = List<String>.from(event.inputValues);
    final name = inputValues[0];
    final birthday = inputValues[4];
    final phoneNo = '+63${inputValues[3]}';
    final emergencyContactName = inputValues[5];
    final emergencyContactNo = '+63${inputValues[6]}';
    final relationship = inputValues[7];
    final address = '${inputValues[1]} ${inputValues[2]}';
    final gender = event.selectedOption == 'Female' ? 'female' : 'male';
    log('$name, $birthday, $phoneNo, $emergencyContactName, $emergencyContactNo, $relationship, $address, $gender, ${event.idUrl}');
    try {
      final response = await profileServices.verificationRequest(name, gender, phoneNo, address, birthday, emergencyContactName, emergencyContactNo, relationship, event.idUrl!);
      final statucCode = response['statusCode'];
      final data = response['data'];
      if(statucCode == 200){
        log('The verification request is: $statucCode');
        emit(VerificationOfUserSuccess());
      } else {
        log('The verification request is: $statucCode, $data');
        emit(VerificationOfUserError('Failed to submit verification request: $statucCode'));
      }
    } catch (e) {
      emit(VerificationOfUserError(e.toString()));
    }
  }
}
