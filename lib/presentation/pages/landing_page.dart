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
            toast(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFCFCFC),
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 48,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 70,
                          width: 70,
                        ),
                        Text(
                          'Welcome to',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B),
                          ),
                        ),
                        Text(
                          'SafeTrack',
                          style: GoogleFonts.quicksand(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF023E8A),
                          ),
                        ),
                        const Spacer(),
                        Opacity(
                          opacity: 0.50,
                          child: Image.asset(
                            'assets/images/center.jpeg',
                            height: 200,
                            width: 400,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 250,
                          child: Text(
                            'Your Barangay Your Voice',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                        const Spacer(),
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
                              backgroundColor: const Color(0xFF023E8A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCFCFC),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: const Color(0xCC3B3B3B),
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
                                  color: const Color(0xFF023E8A),
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color(0xFF023E8A),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
            ),
          );
        },
      ),
    );
  }
}
