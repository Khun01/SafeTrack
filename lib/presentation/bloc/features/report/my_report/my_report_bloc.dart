import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_event.dart';
import 'package:safetrack/presentation/bloc/features/report/my_report/my_report_state.dart';
import 'package:safetrack/services/feature_services.dart';

class MyReportBloc extends Bloc<MyReportEvent, MyReportState> {
  final FeatureServices featureServices;
  MyReportBloc({required this.featureServices}) : super(MyReportInitial()) {
    on<SubmitButtonEvent>(submitButtonEvent);
    on<FetchingMyReportEvent>(fetchingMyReportEvent);
    on<SearchMyReportEvent>(searchMyReportEvent);
  }

  FutureOr<void> submitButtonEvent(
      SubmitButtonEvent event, Emitter<MyReportState> emit) async {
    emit(SubmitReportLoadingState());
    log('The submit button is clicked');
    try {
      final priority = event.priority == 'High'
          ? 'high'
          : event.priority == 'Medium'
              ? 'medium'
              : 'low';
      log('The data is = Image: ${event.reportImage}, Priority type: $priority, Description: ${event.description}, Location: ${event.location}');
      final response = await featureServices.submitReport(
        priority,
        event.location,
        event.description,
        event.reportImage,
      );
      final statusCode = response['statusCode'];
      final data = response['data'];
      switch (statusCode) {
        case 201:
          emit(SubmitReportSuccessState());
          break;
        case 403:
          emit(SubmitReportErrorState(
            errorMessage: 'You are not verified to use this feature',
          ));
          break;
        default:
          log('The error in submitting report is: $statusCode, $data');
          emit(SubmitReportErrorState(
            errorMessage: 'Something went wrong',
          ));
          break;
      }
    } catch (e) {
      log('The error in submitting report is: ${e.toString()}');
      emit(SubmitReportErrorState(errorMessage: 'Network Error'));
    }
  }

  FutureOr<void> fetchingMyReportEvent(
      FetchingMyReportEvent event, Emitter<MyReportState> emit) async {
    emit(FetchingMyReportState());
    try {
      final myReport = await featureServices.fetchReport();
      emit(FetchingMyReportSuccessState(myReport: myReport));
    } catch (e) {
      emit(FetchingMyReportErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> searchMyReportEvent(
      SearchMyReportEvent event, Emitter<MyReportState> emit) async {
    emit(FetchingMyReportState());
    try {
      final myReport = await featureServices.fetchReport();
      final filteredReports = myReport.where((report) {
        return report.description
                .toLowerCase()
                .contains(event.query.toLowerCase()) ||
            report.location.toLowerCase().contains(event.query.toLowerCase()) ||
            report.priority.toLowerCase() == event.query.toLowerCase() ||
            report.status.toLowerCase() == event.query.toLowerCase() ||
            report.date.toLowerCase() == event.query.toLowerCase();
      }).toList();
      emit(FetchingMyReportSuccessState(myReport: filteredReports));
    } catch (e) {
      emit(FetchingMyReportErrorState(errorMessage: e.toString()));
    }
  }
}
