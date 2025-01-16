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
        color: const Color(0xFFF9FBFF),
        border: Border.all(
          color: const Color(0x103B3B3B),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A3B3B3B),
            offset: Offset(0.0, 10.0),
            blurRadius: 4.0,
            spreadRadius: -4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
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
                          fontSize: 14,
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
                      color: const Color(0x803B3B3B),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Date:',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: const Color(0x803B3B3B),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'January 01, 2025',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: const Color(0x803B3B3B),
                      ),
                    ),
                  ],
                )
                // Row(
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Date:',
                //           style: GoogleFonts.nunito(
                //             fontSize: 10,
                //             fontWeight: FontWeight.bold,
                //             color: const Color(0x803B3B3B),
                //           ),
                //         ),
                //         Text(
                //           'January 01, 2025',
                //           style: GoogleFonts.nunito(
                //             fontSize: 12,
                //             fontWeight: FontWeight.bold,
                //             color: const Color(0x803B3B3B),
                //           ),
                //         ),
                //       ],
                //     ),
                //     const SizedBox(width: 24),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Time:',
                //           style: GoogleFonts.nunito(
                //             fontSize: 10,
                //             color: const Color(0xFF3B3B3B),
                //           ),
                //         ),
                //         Text(
                //           '12:00 PM',
                //           style: GoogleFonts.nunito(
                //             fontSize: 12,
                //             fontWeight: FontWeight.bold,
                //             color: const Color(0x803B3B3B),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
