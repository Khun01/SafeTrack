import 'dart:io';

class MyReport {
  final int id;
  final String priority;
  final String location;
  final String description;
  final String status;
  final String date;
  final File evidence;

  MyReport({
    required this.id,
    required this.priority,
    required this.location,
    required this.description,
    required this.status,
    required this.date,
    required this.evidence,
  });

  factory MyReport.fromJson(Map<String, dynamic> json) {
    return MyReport(
      id: json['id'],
      priority: json['priority_type'],
      location: json['location'],
      description: json['description'],
      status: json['status'],
      date: json['created_at'],
      evidence: File(json['evidence_url']),
    );
  }

  String get formattedTime => _formatTime(date);

  String _formatTime(String time) {
    return time.substring(0, 10);
  }

  @override
  String toString() {
    return 'Concern(location: $location, description: $description, priority_type: $priority, date: $formattedTime)';
  }
}
