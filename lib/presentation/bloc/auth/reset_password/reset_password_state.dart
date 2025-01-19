class ResetPasswordState {
  final String password;
  final String confirmPassword;
  final bool passwordIsNotEmpty;
  final bool confirmPasswordIsNotEmpty;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isPasswordEqualToConfirmedPassword;
  final bool resetPasswordSuccess;
  final bool resetPasswordFailed;
  final bool resetPasswordLoading;
  final String errorMessage;

  
  bool get isFormValid =>
      isPasswordValid &&
      isConfirmPasswordValid &&
      isPasswordEqualToConfirmedPassword;


  ResetPasswordState({
    required this.password,
    required this.confirmPassword,
    required this.passwordIsNotEmpty,
    required this.confirmPasswordIsNotEmpty,
    required this.isPasswordValid,
    required this.isConfirmPasswordValid,
    required this.isPasswordEqualToConfirmedPassword,
    required this.resetPasswordSuccess,
    required this.resetPasswordFailed,
    required this.resetPasswordLoading,
    required this.errorMessage,
  });

  factory ResetPasswordState.initial(){
    return ResetPasswordState(
      password: '',
      confirmPassword: '',
      passwordIsNotEmpty: false,
      confirmPasswordIsNotEmpty: false,
      isPasswordValid: false,
      isConfirmPasswordValid: false,
      isPasswordEqualToConfirmedPassword: false,
      resetPasswordSuccess: false,
      resetPasswordFailed: false,
      resetPasswordLoading: false,
      errorMessage: '',
    );
  }

  ResetPasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? passwordIsNotEmpty,
    bool? confirmPasswordIsNotEmpty,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isPasswordEqualToConfirmedPassword,
    bool? resetPasswordSuccess,
    bool? resetPasswordFailed,
    bool? resetPasswordLoading,
    String? errorMessage,
  }){
    return ResetPasswordState(
      password: password?? this.password,
      confirmPassword: confirmPassword?? this.confirmPassword,
      passwordIsNotEmpty: passwordIsNotEmpty?? this.passwordIsNotEmpty,
      confirmPasswordIsNotEmpty: confirmPasswordIsNotEmpty?? this.confirmPasswordIsNotEmpty,
      isPasswordValid: isPasswordValid?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid?? this.isConfirmPasswordValid,
      isPasswordEqualToConfirmedPassword: isPasswordEqualToConfirmedPassword ?? this.isPasswordEqualToConfirmedPassword,
      resetPasswordSuccess: resetPasswordSuccess?? this.resetPasswordSuccess,
      resetPasswordFailed: resetPasswordFailed?? this.resetPasswordFailed,
      resetPasswordLoading: resetPasswordLoading?? this.resetPasswordLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

}