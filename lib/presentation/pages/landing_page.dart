// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_bloc.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_event.dart';
import 'package:safetrack/presentation/bloc/auth/check_login_status/check_login_status_state.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/pages/auth/register_page.dart';
import 'package:safetrack/presentation/pages/wrapper.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';
import 'package:safetrack/services/auth_services.dart';
import 'package:safetrack/services/global.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckLoginStatusBloc checkLoginStatusBloc =
        CheckLoginStatusBloc(authServices: AuthServices(baseUrl: baseUrl));
    return BlocProvider(
      create: (context) => checkLoginStatusBloc,
      child: BlocConsumer<CheckLoginStatusBloc, CheckLoginStatusState>(
        listener: (context, state) {
          if (state is CheckLoginStatusLoggedIn) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Wrapper()));
          } else if (state is CheckLoginStatusLoggedOut) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          } else if (state is CheckLoginStatusFailed) {
            snackBar(context, state.error, LightColor.primaryColor);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/landing_page_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFFFF),
                          Color(0x99FFFFFF),
                          Color(0x03FFFFFF),
                          Color(0x03FFFFFF),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, bottom: 32, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Together for\n a Safer Tomorrow',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: LightColor.blackPrimaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Your reports make a difference—keep your barangay informed and protected.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: LightColor.blackSecondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<CheckLoginStatusBloc>()
                                    .add(CheckLoginStatusEventToken());
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: LightColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Get Started',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.whitePrimaryTextColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
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
                                              const RegisterPage()));
                                },
                                child: Text(
                                  'Register Now',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: LightColor.primaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: LightColor.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is CheckLoginStatusChecking) ...[
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
          );
        },
      ),
    );
  }
}
