abstract class VerificationEvent {}

class VerificationButtonPressed extends VerificationEvent{}

class VerificationTokenChangedEvent extends VerificationEvent{
  final String token;
  final int index;

  VerificationTokenChangedEvent({required this.token, required this.index});
} 