abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationSuccessState extends VerificationState{
  final String token;
  
  VerificationSuccessState({required this.token});
}

class VerificationLoadingState extends VerificationState{}

class VerificationFailedState extends VerificationState{
  final String error;

  VerificationFailedState({required this.error});
}
