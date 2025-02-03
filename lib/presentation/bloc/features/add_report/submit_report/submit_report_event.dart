abstract class SubmitReportEvent {}

class SubmitButtonEvent extends SubmitReportEvent {
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

