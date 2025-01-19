import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_event.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_state.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';

class ResetPasswordPage extends StatelessWidget {
  final String token;
  final String email;
  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final ResetPasswordBloc resetPasswordBloc =
        ResetPasswordBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => resetPasswordBloc,
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.resetPasswordFailed) {
            log('Ngek error: ${state.errorMessage}');
            toast(context, state.errorMessage);
          } else if (state.resetPasswordSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
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
                            color: Color(0xFF3B3B3B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Reset Password',
                          style: GoogleFonts.nunito(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF3B3B3B),
                          ),
                        ),
                        Text(
                          'Enter your new password to open your account',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0x803B3B3B),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Create your new password to secure your account and get back on track. Make it strong, unique, and ready to keep your data safe!',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0x803B3B3B),
                          ),
                        ),
                        const SizedBox(height: 16),
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
                            context
                                .read<ResetPasswordBloc>()
                                .add(ResetPasswordChanged(password: value));
                          },
                        ),
                        const SizedBox(height: 8),
                        MyForm(
                          label: 'Confirm Password',
                          icon: const Icon(Icons.lock_outline),
                          obscureText: true,
                          errorText: !state.confirmPasswordIsNotEmpty
                              ? 'Enter your password'
                              : (!state.isConfirmPasswordValid
                                  ? 'Confrim password should be greater than 8'
                                  : !state.isPasswordEqualToConfirmedPassword
                                      ? 'Password and confirmed password do not match'
                                      : null),
                          onChanged: (value) {
                            context.read<ResetPasswordBloc>().add(
                                ResetConfirmPasswordChanged(
                                    confirmPassword: value));
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.isFormValid) {
                                context
                                    .read<ResetPasswordBloc>()
                                    .add(ResetPasswordButtonPressed(
                                      email: email,
                                      token: token,
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF023E8A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'Reset Password',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCFCFC),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.resetPasswordLoading) ...[
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
