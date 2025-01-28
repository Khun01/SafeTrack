class RegisterState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool nameIsNotEmpty;
  final bool emailIsNotEmpty;
  final bool passwordIsNotEmpty;
  final bool confirmedPasswordIsNotEmpty;
  final bool registerSuccess;
  final bool registerFailed;
  final bool registerLoading;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isPasswordEqualToConfirmedPassword;
  final String errorMessage;
  final String successMessage;

  bool get isFormValid =>
      isEmailValid &&
      isPasswordValid &&
      isConfirmPasswordValid &&
      isPasswordEqualToConfirmedPassword;

  RegisterState({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.nameIsNotEmpty,
    required this.emailIsNotEmpty,
    required this.passwordIsNotEmpty,
    required this.confirmedPasswordIsNotEmpty,
    required this.registerSuccess,
    required this.registerFailed,
    required this.registerLoading,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isConfirmPasswordValid,
    required this.isPasswordEqualToConfirmedPassword,
    required this.errorMessage,
    required this.successMessage,
  });

  factory RegisterState.initial() {
    return RegisterState(
      name: '',
      email: '',
      password: '',
      confirmPassword: '',
      nameIsNotEmpty: false,
      emailIsNotEmpty: false,
      passwordIsNotEmpty: false,
      confirmedPasswordIsNotEmpty: false,
      registerSuccess: false,
      registerFailed: false,
      registerLoading: false,
      isEmailValid: false,
      isPasswordValid: false,
      isConfirmPasswordValid: false,
      isPasswordEqualToConfirmedPassword: false,
      errorMessage: '',
      successMessage: '',
    );
  }

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? nameIsNotEmpty,
    bool? emailIsNotEmpty,
    bool? passwordIsNotEmpty,
    bool? confirmedPasswordIsNotEmpty,
    bool? registerSuccess,
    bool? registerFailed,
    bool? registerLoading,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isPasswordEqualToConfirmedPassword,
    String? errorMessage,
    String? successMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      nameIsNotEmpty: nameIsNotEmpty ?? this.nameIsNotEmpty,
      emailIsNotEmpty: emailIsNotEmpty ?? this.emailIsNotEmpty,
      passwordIsNotEmpty: passwordIsNotEmpty ?? this.passwordIsNotEmpty,
      confirmedPasswordIsNotEmpty:
          confirmedPasswordIsNotEmpty ?? this.confirmedPasswordIsNotEmpty,
      registerSuccess: registerSuccess ?? this.registerSuccess,
      registerFailed: registerFailed ?? this.registerFailed,
      registerLoading: registerLoading ?? this.registerLoading,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isPasswordEqualToConfirmedPassword: isPasswordEqualToConfirmedPassword ??
          this.isPasswordEqualToConfirmedPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage?? this.successMessage,
    );
  }
}
