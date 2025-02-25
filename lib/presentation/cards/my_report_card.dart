import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/models/my_report.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/services/global.dart';

class MyReportCard extends StatelessWidget {
  final MyReport myReport;
  const MyReportCard({super.key, required this.myReport});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
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
                  borderRadius: BorderRadius.circular(20),
                  color: LightColor.accentColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    '$evidenceUrl${myReport.evidence}',
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Text(
                          myReport.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: LightColor.blackPrimaryTextColor,
                          ),
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
                            'Date: ${myReport.formattedTime}',
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: myReport.status == 'Completed'
                  ? const Color(0xFF4CAF50)
                  : myReport.status == 'under_review' ||
                          myReport.status == 'in_progress' ||
                          myReport.status == 'resolved'
                      ? const Color(0xFF2196F3)
                      : myReport.status == 'rejected'
                          ? const Color(0xFFF44336)
                          : const Color(0xFFFFAE00),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(4),
                bottomLeft: Radius.circular(22),
              ),
            ),
            child: Text(
              myReport.status == 'new'
                  ? 'Pending'
                  : myReport.status == 'under_review' ||
                          myReport.status == 'in_progress' ||
                          myReport.status == 'resolved'
                      ? 'Investigating'
                      : myReport.status == 'rejected'
                          ? 'Rejected'
                          : myReport.status,
              style: GoogleFonts.quicksand(
                fontSize: 12,
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
