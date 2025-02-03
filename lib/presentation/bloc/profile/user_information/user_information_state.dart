import 'package:safetrack/models/user.dart';

abstract class UserInformationState {}

class UserInformationInitial extends UserInformationState {}

class UserInformationLoadingState extends UserInformationState {}

class UserInformationSuccessState extends UserInformationState {
  final User user;

  UserInformationSuccessState({required this.user});
}

class UserInformationFailedState extends UserInformationState {
  final String errorMessage;

  UserInformationFailedState({required this.errorMessage});
}
