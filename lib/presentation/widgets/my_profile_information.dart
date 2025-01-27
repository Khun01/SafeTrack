import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/theme/colors.dart';

class MyProfileInformation extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subheading;
  final String info;
  const MyProfileInformation({
    super.key,
    required this.title,
    required this.icon,
    required this.subheading,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: LightColor.blackPrimaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                decoration: BoxDecoration(
                  color: const Color(0x1A023E8A),
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Icon(
                  icon,
                  color: LightColor.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subheading,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: LightColor.blackAccentColor,
                    ),
                  ),
                  Text(
                    info,
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: LightColor.blackPrimaryTextColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 3,
            color: LightColor.dividerColor,
          ),
        ],
      ),
    );
  }
}
