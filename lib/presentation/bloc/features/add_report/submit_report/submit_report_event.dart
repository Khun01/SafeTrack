abstract class SubmitReportEvent {}

class SubmitButtonEvent extends SubmitReportEvent {
  final String reportImage;
  final String title;
  final String description;
  final String location;

  SubmitButtonEvent({
    required this.reportImage,
    required this.title,
    required this.description,
    required this.location,
  });
}

