abstract class ResetPasswordEvent {}

class ResetPasswordButtonPressed extends ResetPasswordEvent {
  final String email;
  final String token;

  ResetPasswordButtonPressed({required this.email, required this.token});
}

class ResetPasswordChanged extends ResetPasswordEvent {
  final String password;

  ResetPasswordChanged({required this.password});
}

class ResetConfirmPasswordChanged extends ResetPasswordEvent {
  final String confirmPassword;

  ResetConfirmPasswordChanged({required this.confirmPassword});
}


class ResetPasswordFailedReset extends ResetPasswordEvent{}

class ResetPasswordSuccessReset extends ResetPasswordEvent{}
