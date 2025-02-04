import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class MyTutorialCoachMark extends StatefulWidget {
  final String title;
  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;

  const MyTutorialCoachMark({
    super.key,
    required this.title,
    required this.text,
    this.skip = 'Skip',
    this.next = 'Next',
    this.onSkip,
    this.onNext,
  });

  @override
  State<MyTutorialCoachMark> createState() => _MyTutorialCoachMarkState();
}

class _MyTutorialCoachMarkState extends State<MyTutorialCoachMark>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 20,
      duration: const Duration(milliseconds: 800),
    )..repeat(min: 0, max: 20, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animationController.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.quicksand(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: LightColor.blackPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.text,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: LightColor.blackPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onSkip,
                  style: TextButton.styleFrom(
                      foregroundColor: LightColor.primaryColor,
                      textStyle: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  child: Text(widget.skip),
                ),
                ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.next,
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: LightColor.whitePrimaryTextColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
