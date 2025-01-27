import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_event.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_state.dart';
import 'package:safetrack/presentation/pages/auth/verification_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/theme/colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordBloc forgotPasswordBloc =
        ForgotPasswordBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => forgotPasswordBloc,
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.forgotPasswordFailed) {
            log('Ngek error');
            toast(context, state.errorMessage);
          } else if (state.forgotPasswordSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationPage(email: state.email)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: LightColor.backgroundColor,
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
                          'Forgot Password',
                          style: GoogleFonts.quicksand(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: LightColor.blackPrimaryTextColor,
                          ),
                        ),
                        Text(
                          'Please enter your email address',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: LightColor.blackSecondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Forgot your password? Enter your email to reset it and regain access to your account.',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: LightColor.blackSecondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        MyForm(
                          label: 'Email',
                          icon: const Icon(Icons.mail_outline),
                          errorText: !state.emailIsNotEmpty
                              ? 'Enter your email'
                              : (!state.isEmailValid ? 'Invalid email' : null),
                          onChanged: (value) {
                            context
                                .read<ForgotPasswordBloc>()
                                .add(ForgotPasswordEmailChanged(email: value));
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
                                    .read<ForgotPasswordBloc>()
                                    .add(ForgotPasswordButtonPressed());
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
                              'Forgot Password',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: LightColor.whitePrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.forgotPasswordLoading) ...[
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
