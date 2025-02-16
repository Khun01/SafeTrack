import 'package:intl/intl.dart';

class EventSchedule {
  final int? id;
  final String startTime;
  final String endTime;
  final String description;

  EventSchedule({
    this.id,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  factory EventSchedule.fromJson(Map<String, dynamic> json) {
    return EventSchedule(
      id: json['id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      description: json['description'],
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

  @override
  String toString() {
    return 'Event(Start time : $startTime, End: Time $endTime, Description: $description)';
  }
}
