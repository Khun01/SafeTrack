import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: -40,
            child: SizedBox(
              height: 150,
              child: Image.asset(
                'assets/images/announcement_image.png',
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SafeTrack',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                  Text(
                    announcement.date,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: const Color(0xCC3B3B3B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                announcement.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3B3B3B),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Text(
                  announcement.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: const Color(0xCC3B3B3B),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: const Color(0xFF023E8A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'See Details ...',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: const Color(0xFFFCFCFC),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
