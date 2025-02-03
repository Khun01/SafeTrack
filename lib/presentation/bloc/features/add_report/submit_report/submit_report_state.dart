abstract class SubmitReportState {}

final class SubmitReportInitial extends SubmitReportState {}

class SubmitReportSuccessState extends SubmitReportState {}

class SubmitReportErrorState extends SubmitReportState {
  final String errorMessage;

  SubmitReportErrorState({required this.errorMessage});
}

class SubmitReportLoadingState extends SubmitReportState {}