import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_event.dart';
import 'package:safetrack/presentation/bloc/auth/forgot_password/forgot_password_state.dart';
import 'package:safetrack/presentation/pages/auth/verification_page.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordBloc forgotPasswordBloc =
        ForgotPasswordBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => forgotPasswordBloc,
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.forgotPasswordFailed) {
            snackBar(
              context,
              state.errorMessage,
              LightColor.primaryColor,
            );
            Future.delayed(const Duration(milliseconds: 300), () {
              // ignore: use_build_context_synchronously
              context
                  .read<ForgotPasswordBloc>()
                  .add(ForgotPasswordFailedReset());
            });
          } else if (state.forgotPasswordSuccess) {
            controller.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                snackBar(
                  context,
                  state.successMessage,
                  LightColor.primaryColor,
                );
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          VerificationPage(email: state.email),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  context
                      .read<ForgotPasswordBloc>()
                      .add(ForgotPasswordSuccessReset());
                });
                controller.reset();
              }
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: LightColor.backgroundColor,
            body: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: state.forgotPasswordLoading
                  ? Center(
                      child: Lottie.asset(
                        'assets/lottie/register_loading.json',
                      ),
                    )
                  : state.forgotPasswordSuccess
                      ? Center(
                          child: Lottie.asset(
                            'assets/lottie/confirmation.json',
                            controller: controller,
                            onLoaded: (composition) {
                              controller
                                ..duration = composition.duration
                                ..forward();
                            },
                            repeat: false,
                          ),
                        )
                      : state.forgotPasswordFailed
                          ? Center(
                              child: Text(
                                'hahahahah error',
                                style: GoogleFonts.quicksand(
                                    fontSize: 32, color: Colors.black),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 16,
                              ),
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
                                      color:
                                          LightColor.blackSecondaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Forgot your password? Enter your email to reset it and regain access to your account.',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          LightColor.blackSecondaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  MyForm(
                                    label: 'Email',
                                    icon: const Icon(Icons.mail_outline),
                                    errorText: !state.emailIsNotEmpty
                                        ? 'Enter your email'
                                        : (!state.isEmailValid
                                            ? 'Invalid email'
                                            : null),
                                    onChanged: (value) {
                                      context.read<ForgotPasswordBloc>().add(
                                          ForgotPasswordEmailChanged(
                                              email: value));
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (state.isFormValid) {
                                          context.read<ForgotPasswordBloc>().add(
                                              ForgotPasswordButtonPressed());
                                          SystemChannels.textInput
                                              .invokeMethod('TextInput.hide');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            LightColor.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Text(
                                        'Forgot Password',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: LightColor
                                              .whitePrimaryTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
            ),
          );
        },
      ),
    );
  }
}
