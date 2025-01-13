import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/auth/login_page.dart';
import 'package:safetrack/presentation/pages/auth/register_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset('assets/images/lp_bg.png'),
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SafeTrack',
                          style: GoogleFonts.racingSansOne(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF023E8A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Text(
                            'Your Barangay, Your Voice',
                            style: GoogleFonts.nunito(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3B3B3B),
                            ),
                          ),
                        ),
                        Text(
                          'Connect with your barangay officials, report issues, and track resolutions with ease.',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: const Color(0xFF3B3B3B),
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: ActionSlider.standard(
                            sliderBehavior: SliderBehavior.stretch,
                            backgroundColor: const Color(0xFF023E8A),
                            toggleColor: const Color(0xFFFCFCFC),
                            action: (controller) async {
                              controller.loading();
                              await Future.delayed(const Duration(seconds: 3));
                              controller.success();
                              await Future.delayed(const Duration(seconds: 1));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                              controller.reset();
                            },
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.nunito(
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
                              'Not registered yet?',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                color: const Color(0x803B3B3B),
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
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: const Color(0xFF023E8A),
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color(0xFF023E8A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
