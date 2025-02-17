import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/announcement.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.only(left: 16, bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FBFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x1A023E8A)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A023E8A),
                offset: Offset(0.0, 10.0),
                blurRadius: 4.0,
                spreadRadius: -4.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SafeTrack',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: LightColor.blackPrimaryTextColor,
                    ),
                  ),
                  Text(
                    announcement.date,
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      color: LightColor.blackSecondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                announcement.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: LightColor.blackPrimaryTextColor,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Text(
                  announcement.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: LightColor.blackSecondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 14,
          right: -16,
          child: SizedBox(
            height: 120,
            child: Image.asset(
              'assets/images/announcement_image.png',
            ),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 32,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: LightColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            onPressed: () {},
            child: Text(
              'See Details ...',
              style: GoogleFonts.quicksand(
                fontSize: 12,
                color: LightColor.whitePrimaryTextColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
