import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            width:  60,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFE5E9F4),
            ),
            child: Image.asset(image),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xCC3B3B3B),
            ),
          )
        ],
      ),
    );
  }
}
