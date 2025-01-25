abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {}

class LoginEmailChanged extends LoginEvent{
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent{
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginFailedReset extends LoginEvent {}