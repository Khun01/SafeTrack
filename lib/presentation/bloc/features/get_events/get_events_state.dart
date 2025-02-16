import 'package:safetrack/models/events/event.dart';

abstract class GetEventsState {}

final class GetEventsInitial extends GetEventsState {}

class GetEventsSuccessState extends GetEventsState {
  final List<Event>? event;
  final int? expandedIndex;

  GetEventsSuccessState({this.event, this.expandedIndex});
}

class GetEventsLoadingState extends GetEventsState {}

class GetEventsFailedState extends GetEventsState {
  final String error;

  GetEventsFailedState({required this.error});
}
