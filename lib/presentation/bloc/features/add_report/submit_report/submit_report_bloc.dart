import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/submit_report/submit_report_event.dart';
import 'package:safetrack/presentation/bloc/features/add_report/submit_report/submit_report_state.dart';
import 'package:safetrack/services/feature_services.dart';

class SubmitReportBloc extends Bloc<SubmitReportEvent, SubmitReportState> {
  final FeatureServices featureServices;
  SubmitReportBloc({required this.featureServices})
      : super(SubmitReportInitial()) {
    on<SubmitButtonEvent>(submitButtonEvent);
  }

  FutureOr<void> submitButtonEvent(
      SubmitButtonEvent event, Emitter<SubmitReportState> emit) async {
    emit(SubmitReportLoadingState());
    log('The submit button is clicked');
    try {
      final priority = event.priority == 'High' ? 'high' : event.priority == 'Medium' ? 'medium' : 'low';
      log('The data is = Image: ${event.reportImage}, Title: $priority, Description: ${event.description}, Location: ${event.location}');
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
}
