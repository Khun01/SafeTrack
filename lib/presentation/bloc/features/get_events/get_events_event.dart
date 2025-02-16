abstract class GetEventsEvent {}

class GetEvents extends GetEventsEvent {}

class ToggleExpansionEvent extends GetEventsEvent {
  final int index;

  ToggleExpansionEvent(this.index);
}