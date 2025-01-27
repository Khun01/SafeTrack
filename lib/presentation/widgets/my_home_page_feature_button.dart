import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/theme/colors.dart';

class MyHomePageFeatureButton extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const MyHomePageFeatureButton({
    super.key,
    required this.onTap,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: const Color(0xFFE5E9F4),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A023E8A),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Image.asset(image),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: LightColor.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
