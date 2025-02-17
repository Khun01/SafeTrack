abstract class MyReportState {}

final class SubmitReportInitial extends MyReportState {}

class SubmitReportSuccessState extends MyReportState {}

class SubmitReportErrorState extends MyReportState {
  final String errorMessage;

  SubmitReportErrorState({required this.errorMessage});
}

class SubmitReportLoadingState extends MyReportState {}