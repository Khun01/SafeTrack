class ForgotPasswordState {
  final String email;
  final bool emailIsNotEmpty;
  final bool isEmailValid;
  final bool forgotPasswordSuccess;
  final bool forgotPasswordFailed;
  final bool forgotPasswordLoading;
  final String errorMessage;
  final String successMessage;

  bool get isFormValid => isEmailValid;

  ForgotPasswordState({
    required this.email,
    required this.emailIsNotEmpty,
    required this.isEmailValid,
    this.forgotPasswordSuccess = false,
    this.forgotPasswordFailed = false,
    this.forgotPasswordLoading = false,
    this.errorMessage = '',
    this.successMessage = '',
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      email: '',
      emailIsNotEmpty: false,
      isEmailValid: false,
      forgotPasswordSuccess: false,
      forgotPasswordFailed: false,
      forgotPasswordLoading: false,
      errorMessage: '',
      successMessage: '',
    );
  }

  ForgotPasswordState copyWith({
    String? email,
    bool? emailIsNotEmpty,
    bool? isEmailValid,
    bool? forgotPasswordSuccess,
    bool? forgotPasswordFailed,
    bool? forgotPasswordLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      emailIsNotEmpty: emailIsNotEmpty ?? this.emailIsNotEmpty,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      forgotPasswordSuccess: forgotPasswordSuccess?? this.forgotPasswordSuccess,
      forgotPasswordFailed: forgotPasswordFailed?? this.forgotPasswordFailed,
      forgotPasswordLoading: forgotPasswordLoading?? this.forgotPasswordLoading,
      errorMessage: errorMessage?? this.errorMessage,
      successMessage: successMessage?? this.successMessage,
    );
  }
}
