abstract class MyReportEvent {}

class SubmitButtonEvent extends MyReportEvent {
  final String reportImage;
  final String priority;
  final String description;
  final String location;

  SubmitButtonEvent({
    required this.reportImage,
    required this.priority,
    required this.description,
    required this.location,
  });
}

class FetchingMyReportEvent extends MyReportEvent {}

class SearchMyReportEvent extends MyReportEvent {
  final String query;

  SearchMyReportEvent({required this.query});
}
