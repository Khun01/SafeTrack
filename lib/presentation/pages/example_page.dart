import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage>
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
      backgroundColor: LightColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Lottie Animations',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: LightColor.blackPrimaryTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/confirmation.json',
            controller: controller,
            onLoaded: (composition) {
              controller
                ..duration = composition.duration
                ..forward();
            },
            repeat: false,
          ),
          AnimatedOpacity(
            opacity: animationFinished ? 1 : 0,
            duration: const Duration(seconds: 1),
            child: Text(
              'Animation Completed',
              style: GoogleFonts.quicksand(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: LightColor.blackPrimaryTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
