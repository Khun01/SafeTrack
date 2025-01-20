import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/activities.dart';

class ActivitiesCard extends StatelessWidget {
  final Activities activities;
  const ActivitiesCard({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: 80,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activities.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ),
                      Text(
                        activities.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: const Color(0x803B3B3B),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'Priority:',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            activities.priority,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: activities.priority == 'High'
                                  ? const Color(0xFFB00003)
                                  : activities.priority == 'Medium'
                                      ? const Color(0xFFBCB000)
                                      : const Color(0xFF0060B0),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            activities.status,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: activities.status == 'Completed'
                                  ? const Color(0xFF4CAF50)
                                  : activities.status == 'Pending'
                                      ? const Color(0xFFFFAE00)
                                      : const Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.more_vert,
                color: Color(0xFF3B3b3B),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 2)
        ],
      ),
    );
  }
}
