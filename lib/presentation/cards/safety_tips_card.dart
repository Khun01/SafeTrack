import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/safety_tips.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class SafetyTipsCard extends StatelessWidget {
  final SafetyTips safetyTips;
  const SafetyTipsCard({super.key, required this.safetyTips});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                safetyTips.title == 'flood'
                    ? const Color(0x1A002E6B)
                    : const Color(0x1A6E1109),
                safetyTips.title == 'flood'
                    ? const Color(0x800059D1)
                    : const Color(0x80D42111),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    safetyTips.heading,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: LightColor.blackPrimaryTextColor,
                    ),
                  ),
                  Text(
                    safetyTips.date,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      color: LightColor.blackSecondaryTextColor,
                    ),
                  ),
                ],
              ),
              Text(
                safetyTips.subheading,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  color: LightColor.blackSecondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: safetyTips.title == 'flood'
                  ? const Color(0xFF0059D1)
                  : const Color(0xFFD42111),
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                top: BorderSide(color: Color(0xFFE8D3D3), width: 1),
                left: BorderSide(color: Color(0xFFE8D3D3), width: 1),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Text(
              'Learn more',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: LightColor.whitePrimaryTextColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
