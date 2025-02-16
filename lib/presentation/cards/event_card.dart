// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:safetrack/models/events/event_schedule.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String firstStartTime;
  final String lastEndTime;
  final List<EventSchedule> schedule;
  final bool isExpanded;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.firstStartTime,
    required this.lastEndTime,
    required this.schedule,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    log('Current expandedIndex in state: $isExpanded');
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 13),
                  Text(
                    firstStartTime,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: LightColor.blackSecondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lastEndTime,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: LightColor.blackSecondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: IntrinsicHeight(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.blackPrimaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    description,
                                    style: GoogleFonts.quicksand(
                                      fontSize: 12,
                                      color: LightColor.blackPrimaryTextColor,
                                    ),
                                  ),
                                  isExpanded
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            Text(
                                              'Schedule time:',
                                              style: GoogleFonts.quicksand(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: LightColor
                                                    .blackPrimaryTextColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            for (var event in schedule)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 4,
                                                ),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${formatTime(event.startTime)} - ${formatTime(event.endTime)}',
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: LightColor
                                                              .blackPrimaryTextColor,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ': ${event.description}',
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          fontSize: 12,
                                                          color: LightColor
                                                              .blackPrimaryTextColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 2,
            color: LightColor.accentColor,
          )
        ],
      ),
    );
  }

  String formatTime(String time) {
    try {
      final parsedTime = DateFormat("HH:mm").parse(time);
      return DateFormat("h:mm a").format(parsedTime);
    } catch (e) {
      return time;
    }
  }
}
