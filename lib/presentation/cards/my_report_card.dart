import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/my_report.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class MyReportCard extends StatelessWidget {
  final MyReport myReport;
  const MyReportCard({super.key, required this.myReport});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: LightColor.whitePrimaryTextColor,
            border: Border.all(color: LightColor.accentColor),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A023E8A),
                offset: Offset(0.0, 10.0),
                blurRadius: 4.0,
                spreadRadius: -4.0,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: LightColor.accentColor,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myReport.location,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: LightColor.blackPrimaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        myReport.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 11,
                          color: LightColor.blackSecondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Priority: ',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    color: LightColor.blackAccentColor,
                                  ),
                                ),
                                TextSpan(
                                  text: myReport.priority,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: myReport.priority == 'High'
                                        ? const Color(0xFFFF0101)
                                        : myReport.priority == 'Medium'
                                            ? const Color(0xFFBCB000)
                                            : const Color(0xFFADD8E6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Date: ${myReport.date}',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              color: LightColor.blackAccentColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: myReport.status == 'Completed'
                  ? const Color(0xFF4CAF50)
                  : myReport.status == 'Investigating'
                      ? const Color(0xFF2196F3)
                      : const Color(0xFFFFAE00),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(4),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              myReport.status,
              style: GoogleFonts.quicksand(
                fontSize: 10,
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
