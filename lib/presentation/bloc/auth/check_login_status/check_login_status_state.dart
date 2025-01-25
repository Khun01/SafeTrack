abstract class CheckLoginStatusState {}

class CheckLoginStatusInitial extends CheckLoginStatusState {}

class CheckLoginStatusChecking extends CheckLoginStatusState {}

class CheckLoginStatusLoggedIn extends CheckLoginStatusState {}

class CheckLoginStatusLoggedOut extends CheckLoginStatusState {}

class CheckLoginStatusFailed extends CheckLoginStatusState {
  final String error;

  CheckLoginStatusFailed({required this.error});
}
