import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          const Center(
            child: Icon(
              Icons.account_circle,
              color: LightColor.primaryColor,
              size: 50,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: LightColor.blackSecondaryTextColor,
                ),
              ),
              Text(
                'John Brandon Lambino',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: LightColor.blackPrimaryTextColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.notifications,
                size: 28, color: LightColor.primaryColor),
          ),
        ],
      ),
    );
  }
}
