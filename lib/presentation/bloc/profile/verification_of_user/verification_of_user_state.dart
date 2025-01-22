abstract class VerificationOfUserState {}

class VerificationOfUserInitial extends VerificationOfUserState {}

class VerificationOfUserLoading extends VerificationOfUserState {}

class VerificationOfUserSuccess extends VerificationOfUserState {}

class VerificationOfUserError extends VerificationOfUserState {
  final String errorMessage;

  VerificationOfUserError(this.errorMessage);
}
