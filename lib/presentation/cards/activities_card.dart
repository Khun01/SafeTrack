import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/activities.dart';

class ActivitiesCard extends StatelessWidget {
  final Activities activities;
  const ActivitiesCard({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(
          color: const Color(0xFFE5E9F4),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        activities.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      activities.status,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    activities.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Date:',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B),
                      ),
                    ),
                    const SizedBox(width: 100,),
                    Text(
                      'Time:',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0x803B3B3B),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'January 01, 2025',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                    const SizedBox(width: 100,),
                    Text(
                      '12:00 PM',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
