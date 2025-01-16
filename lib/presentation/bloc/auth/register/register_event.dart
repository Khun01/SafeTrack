abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {}

class RegisterNameChanged extends RegisterEvent{
  final String name;

  RegisterNameChanged({required this.name});
}

class RegisterEmailChanged extends RegisterEvent{
  final String email;

  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent{
  final String password;

  RegisterPasswordChanged({required this.password});
}

class RegisterConfirmPasswordChanged extends RegisterEvent{
  final String confirmPassword;

  RegisterConfirmPasswordChanged({required this.confirmPassword});
}
