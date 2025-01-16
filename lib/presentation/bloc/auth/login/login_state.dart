class LoginState {
  final String email;
  final String password;
  final bool emailIsNotEmpty;
  final bool passwordIsNotEmpty;
  final bool loginSuccess;
  final bool loginFailed;
  final bool loginLoading;
  final bool isEmailValid;
  final bool isPasswordValid;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    required this.email,
    required this.password,
    required this.emailIsNotEmpty,
    required this.passwordIsNotEmpty,
    required this.loginSuccess,
    required this.loginFailed,
    required this.loginLoading,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.errorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      email: "",
      password: '',
      emailIsNotEmpty: false,
      passwordIsNotEmpty: false,
      loginSuccess: false,
      loginFailed: false,
      loginLoading: false,
      isEmailValid: true,
      isPasswordValid: true,
      errorMessage: '',
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? emailIsNotEmpty,
    bool? passwordIsNotEmpty,
    bool? loginSuccess,
    bool? loginFailed,
    bool? loginLoading,
    bool? isEmailValid,
    bool? isPasswordValid,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailIsNotEmpty: emailIsNotEmpty?? this.emailIsNotEmpty,
      passwordIsNotEmpty: passwordIsNotEmpty?? this.passwordIsNotEmpty,
      loginSuccess: loginSuccess?? this.loginSuccess,
      loginFailed: loginFailed?? this.loginFailed,
      loginLoading: loginLoading?? this.loginLoading,
      isEmailValid: isEmailValid?? this.isEmailValid,
      isPasswordValid: isPasswordValid?? this.isPasswordValid,
      errorMessage: errorMessage?? this.errorMessage,
    );
  }
}
