import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/theme/colors.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: LightColor.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircularProgressIndicator(color: Color(0xFF023E8A)),
            const SizedBox(width: 24),
            Text(
              'Processing ...',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: LightColor.blackPrimaryTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
