import 'package:safetrack/models/my_report.dart';

abstract class MyReportState {}

final class MyReportInitial extends MyReportState {}

class SubmitReportSuccessState extends MyReportState {}

class SubmitReportErrorState extends MyReportState {
  final String errorMessage;

  SubmitReportErrorState({required this.errorMessage});
}

class SubmitReportLoadingState extends MyReportState {}

class FetchingMyReportState extends MyReportState {}

class FetchingMyReportSuccessState extends MyReportState {
  final List<MyReport> myReport;

  FetchingMyReportSuccessState({required this.myReport});
}

class FetchingMyReportErrorState extends MyReportState {
  final String errorMessage;

  FetchingMyReportErrorState({required this.errorMessage});
}