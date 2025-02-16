import 'dart:convert';
import 'dart:ui';

import 'package:safetrack/models/events/event_schedule.dart';
import 'package:safetrack/services/global.dart';

class Event {
  final int? id;
  final String title;
  final String? description;
  final String? date;
  final Color color;
  final List<EventSchedule>? schedule;

  Event({
    this.id,
    required this.title,
    this.description,
    this.date,
    required this.color,
    this.schedule,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      color: hexToColor(json['color']),
      schedule: (json['schedules'] as List?)
              ?.map((schedule) => EventSchedule.fromJson(schedule))
              .toList() ??
          [],
    );
  }

  static List<Event> fromJsonList(String jsonString) {
    final data = json.decode(jsonString);
    return List<Event>.from(data.map((event) => Event.fromJson(event)));
  }

  String get formattedStartTime {
    return schedule?.first.formatTime(schedule!.first.startTime) ?? '';
  }

  String get formattedEndTime {
    return schedule?.last.formatTime(schedule!.last.endTime) ?? '';
  }

  @override
  String toString() {
    return 'Event(title: $title, color: $color, Schedule: $schedule)';
  }
}
