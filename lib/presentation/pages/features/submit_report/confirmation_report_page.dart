import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/pages/wrapper.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class ConfirmationReportPage extends StatefulWidget {
  const ConfirmationReportPage({super.key});

  @override
  State<ConfirmationReportPage> createState() => _ConfirmationReportPageState();
}

class _ConfirmationReportPageState extends State<ConfirmationReportPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  bool animationFinished = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationFinished = true;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/confirmation.json',
                      height: 250,
                      controller: controller,
                      onLoaded: (composition) {
                        controller
                          ..duration = composition.duration
                          ..forward();
                      },
                      repeat: false,
                    ),
                    const SizedBox(height: 16),
                    AnimatedOpacity(
                      opacity: animationFinished ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        'Report Submitted Successfully!',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedOpacity(
                      opacity: animationFinished ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        "Thank you for your input. We'll review your report promptly and take the necessary actions. Stay tuned for updates.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: LightColor.blackSecondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AnimatedOpacity(
                  opacity: animationFinished ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Wrapper(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: LightColor.whitePrimaryTextColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
