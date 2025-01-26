abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSuccessfully extends LogoutState {}

class LogoutFailed extends LogoutState {
  final String error;

  LogoutFailed({required this.error});
}

class LogoutLoading extends LogoutState {}
