import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/features/get_events/get_events_event.dart';
import 'package:safetrack/presentation/bloc/features/get_events/get_events_state.dart';
import 'package:safetrack/services/feature_services.dart';

class GetEventsBloc extends Bloc<GetEventsEvent, GetEventsState> {
  final FeatureServices featureServices;
  GetEventsBloc({required this.featureServices}) : super(GetEventsInitial()) {
    on<GetEvents>(getEvents);
    on<ToggleExpansionEvent>(toggleExpansionEvent);
  }

  int? expandedEventIndex;

  FutureOr<void> getEvents(
      GetEvents event, Emitter<GetEventsState> emit) async {
    emit(GetEventsLoadingState());
    try {
      final events = await featureServices.fetchEvents();
      log('the eventsare: $events');
      emit(GetEventsSuccessState(event: events));
    } catch (e) {
      log(e.toString());
      emit(GetEventsFailedState(error: e.toString()));
    }
  }

  FutureOr<void> toggleExpansionEvent(
      ToggleExpansionEvent event, Emitter<GetEventsState> emit) async {
    try {
      if (state is GetEventsSuccessState) {
        final currentState = state as GetEventsSuccessState;
        if (expandedEventIndex == event.index) {
          expandedEventIndex = null;
        } else {
          expandedEventIndex = event.index;
        }
        log('Current expandedEventIndex toggle: $expandedEventIndex');
        emit(GetEventsSuccessState(
          event: currentState.event,
          expandedIndex: expandedEventIndex,
        ));
      }
    } catch (e) {
      log('Error in toggleExpansionEvent: $e');
    }
  }
}
