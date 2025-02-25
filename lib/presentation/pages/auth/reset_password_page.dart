import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_event.dart';
import 'package:safetrack/presentation/bloc/auth/reset_password/reset_password_state.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/widgets/my_form.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;
  final String email;
  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
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
    final ResetPasswordBloc resetPasswordBloc =
        ResetPasswordBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => resetPasswordBloc,
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.resetPasswordFailed) {
            snackBar(context, state.errorMessage, LightColor.primaryColor,);
            Future.delayed(const Duration(milliseconds: 300), () {
              // ignore: use_build_context_synchronously
              context.read<ResetPasswordBloc>().add(ResetPasswordFailedReset());
            });
          } else if (state.resetPasswordSuccess) {
            controller.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                snackBar(context, state.successMessage, LightColor.primaryColor,);
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginPage(),
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
                      .read<ResetPasswordBloc>()
                      .add(ResetPasswordSuccessReset());
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
              child: state.resetPasswordLoading
                  ? Center(
                      child: Lottie.asset(
                        'assets/lottie/register_loading.json',
                      ),
                    )
                  : state.resetPasswordSuccess
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
                      : Padding(
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
                                'Reset Password',
                                style: GoogleFonts.quicksand(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: LightColor.blackPrimaryTextColor,
                                ),
                              ),
                              Text(
                                'Enter your new password to open your account',
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: LightColor.blackSecondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Create your new password to secure your account and get back on track. Make it strong, unique, and ready to keep your data safe!',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.blackSecondaryTextColor,
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
                                  context.read<ResetPasswordBloc>().add(
                                      ResetPasswordChanged(password: value));
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
                                            email: widget.email,
                                            token: widget.token,
                                          ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: LightColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    'Reset Password',
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
            ),
          );
        },
      ),
    );
  }
}
