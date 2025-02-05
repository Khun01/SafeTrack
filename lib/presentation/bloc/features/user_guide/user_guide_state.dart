abstract class UserGuideState {}

class UserGuideInitial extends UserGuideState {}

class UserGuideHasntSeenState extends UserGuideState {}

class UserGuideHasSeenState extends UserGuideState {}

class UserGuideFinishedState extends UserGuideState {}

class UserGuideErrorState extends UserGuideState {
  final String errorMessage;

  UserGuideErrorState({required this.errorMessage});
}