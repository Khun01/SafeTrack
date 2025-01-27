import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/my_report.dart';
import 'package:safetrack/theme/colors.dart';

class MyReportCard extends StatelessWidget {
  final MyReport myReport;
  const MyReportCard({super.key, required this.myReport});

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
                        myReport.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                      ),
                      Text(
                        myReport.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: LightColor.blackSecondaryTextColor,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'Priority:',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              color: LightColor.blackSecondaryTextColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            myReport.priority,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: myReport.priority == 'High'
                                  ? const Color(0xFFB00003)
                                  : myReport.priority == 'Medium'
                                      ? const Color(0xFFBCB000)
                                      : const Color(0xFF0060B0),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            myReport.status,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: myReport.status == 'Completed'
                                  ? const Color(0xFF4CAF50)
                                  : myReport.status == 'Pending'
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
                color: LightColor.blackSecondaryTextColor,
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
