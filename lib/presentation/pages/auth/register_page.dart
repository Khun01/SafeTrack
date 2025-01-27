import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/register/register_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/register/register_event.dart';
import 'package:safetrack/presentation/bloc/auth/register/register_state.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool valueCheckBox = false;

  void onChanged(bool? newValue) {
    setState(() {
      valueCheckBox = newValue ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc =
        RegisterBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => registerBloc,
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.registerFailed) {
            log('Ngek error: ${state.errorMessage}');
            toast(context, state.errorMessage);
          } else if (state.registerSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: LightColor.backgroundColor,
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                  color: LightColor.blackPrimaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Create Account',
                                style: GoogleFonts.quicksand(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: LightColor.blackPrimaryTextColor,
                                ),
                              ),
                              Text(
                                'Please fill in the form to continue',
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: LightColor.blackSecondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              MyForm(
                                label: 'Full name',
                                icon: const Icon(Icons.person_outline),
                                errorText: !state.nameIsNotEmpty
                                    ? 'Enter your full name'
                                    : null,
                                onChanged: (value) {
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterNameChanged(name: value));
                                },
                              ),
                              const SizedBox(height: 8),
                              MyForm(
                                label: 'Email',
                                icon: const Icon(Icons.mail_outline),
                                errorText: !state.emailIsNotEmpty
                                    ? 'Enter your email'
                                    : (!state.isEmailValid
                                        ? 'Invalid email'
                                        : null),
                                onChanged: (value) {
                                  context
                                      .read<RegisterBloc>()
                                      .add(RegisterEmailChanged(email: value));
                                },
                              ),
                              const SizedBox(height: 8),
                              MyForm(
                                label: 'Password',
                                icon: const Icon(Icons.lock_outline),
                                obscureText: true,
                                errorText: !state.passwordIsNotEmpty
                                    ? 'Enter your password'
                                    : (!state.isPasswordValid
                                        ? 'Password should be greater than 8'
                                        : null),
                                onChanged: (value) {
                                  log("Password: $value");
                                  context.read<RegisterBloc>().add(
                                      RegisterPasswordChanged(password: value));
                                },
                              ),
                              const SizedBox(height: 8),
                              MyForm(
                                label: 'Confirm Password',
                                icon: const Icon(Icons.lock_outline),
                                obscureText: true,
                                errorText: !state.confirmedPasswordIsNotEmpty
                                    ? 'Enter your password'
                                    : (!state.isConfirmPasswordValid
                                        ? 'Confrim password should be greater than 8'
                                        : !state.isPasswordEqualToConfirmedPassword
                                            ? 'Password and confirmed password do not match'
                                            : null),
                                onChanged: (value) {
                                  log("Confirm Password: $value");
                                  context.read<RegisterBloc>().add(
                                      RegisterConfirmPasswordChanged(
                                          confirmPassword: value));
                                },
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    side: const BorderSide(
                                      width: 1.5,
                                      color: LightColor.blackPrimaryTextColor,
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: valueCheckBox,
                                    onChanged: onChanged,
                                    activeColor: LightColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(500),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'By creating this account, you have agree with Terms and Services',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        color:
                                            LightColor.blackSecondaryTextColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (state.isFormValid) {
                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterButtonPressed());
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: LightColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign up',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: LightColor.whitePrimaryTextColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        side: const BorderSide(
                                          color:
                                              LightColor.blackPrimaryTextColor,
                                        ),
                                      ),
                                      elevation: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/google.png',
                                        height: 25,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Sign in using Google',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              LightColor.blackPrimaryTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      color: LightColor.blackSecondaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        color: LightColor.primaryColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            LightColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.registerLoading) ...[
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const Center(
                      child: MyCircularProgressIndicator(),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
