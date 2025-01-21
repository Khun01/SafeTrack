import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/features/verification_of_user/verification_of_user_event.dart';
import 'package:safetrack/presentation/bloc/features/verification_of_user/verification_of_user_state.dart';

class VerificationOfUserBloc extends Bloc<VerificationOfUserEvent, VerificationOfUserState> {
  VerificationOfUserBloc() : super(VerificationOfUserInitial()) {
  }
}
