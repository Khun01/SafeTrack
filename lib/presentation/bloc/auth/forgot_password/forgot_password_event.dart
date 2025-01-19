abstract class ForgotPasswordEvent {}

class ForgotPasswordButtonPressed extends ForgotPasswordEvent {}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent{
  final String email;

  ForgotPasswordEmailChanged({required this.email});
}