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
      emit(SubmitReportSuccessState());
    } catch (e) {
      log('The error in submitting report is: ${e.toString()}');
      emit(SubmitReportErrorState(errorMessage: e.toString()));
    }
  }
}
