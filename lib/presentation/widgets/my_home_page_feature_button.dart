import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePageFeatureButton extends StatelessWidget {
  final String name;
  final Image image;
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
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFE5E9F4),
            ),
            child: image,
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
