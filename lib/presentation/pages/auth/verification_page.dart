import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/verification/verification_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/verification/verification_event.dart';
import 'package:safetrack/presentation/bloc/auth/verification/verification_state.dart';
import 'package:safetrack/presentation/pages/auth/reset_password_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class VerificationPage extends StatelessWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final VerificationBloc verificationBloc =
        VerificationBloc();
    return BlocProvider(
      create: (context) => verificationBloc,
      child: BlocConsumer<VerificationBloc, VerificationState>(
        listener: (context, state) {
          if (state is VerificationSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordPage(
                  email: email,
                  token: state.token,
                ),
              ),
            );
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
                            color: LightColor.blackPrimaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Verification',
                          style: GoogleFonts.quicksand(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: LightColor.blackPrimaryTextColor,
                          ),
                        ),
                        Text(
                          'Please wait for the code to be submit',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: LightColor.blackSecondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Enter the verification code sent to your email to reset your password.',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: LightColor.blackSecondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            6,
                            (index) => SizedBox(
                              width: 50,
                              height: 55,
                              child: TextFormField(
                                onChanged: (value) {
                                  log('The token in the textField is; $value');
                                  context
                                      .read<VerificationBloc>()
                                      .add(VerificationTokenChangedEvent(
                                        token: value,
                                        index: index,
                                      ));
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: LightColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<VerificationBloc>()
                                  .add(VerificationButtonPressed());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LightColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: LightColor.whitePrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't received the code?",
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  color: LightColor.blackSecondaryTextColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Resend Code',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color: LightColor.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: LightColor.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state is VerificationLoadingState) ...[
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
