abstract class VerificationOfUserEvent {}

class VerificationOfUserClickedButtonEvent extends VerificationOfUserEvent {
  final List<String> inputValues;
  final String? selectedOption;
  final String? idUrl;

  VerificationOfUserClickedButtonEvent({
    required this.inputValues,
    required this.selectedOption,
    required this.idUrl,
  });
}
