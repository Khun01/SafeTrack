import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:safetrack/models/announcement.dart';
import 'package:safetrack/models/events/event.dart';
import 'package:safetrack/models/my_report.dart';
import 'package:safetrack/services/storage.dart';

class FeatureServices {
  final String baseUrl;

  FeatureServices({required this.baseUrl});

  // ------------- FOR GETTING ANNOUNCEMENT ------------- //
  Future<List<Announcement>> fetchAnnouncement() async {
    final user = await Storage.getData();
    String? token = user['token'];
    final response = await http.get(
      Uri.parse('$baseUrl/announcements'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> announcementList = jsonData['announcement'];
      return announcementList
          .map((json) => Announcement.fromJson(json))
          .toList();
    } else {
      log('The status code when fetching announcement is: ${response.statusCode}');
      throw Exception('Failed to load announcement');
    }
  }

  // ------------- FOR GETTING CONTACTS ------------- //

  // ------------- FOR GETTING EVENTS ------------- //
  Future<List<Event>> fetchEvents() async {
    final user = await Storage.getData();
    String? token = user['token'];
    final response = await http.get(
      Uri.parse('$baseUrl/events'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return Event.fromJsonList(response.body);
    } else {
      throw Exception('Failed to load events');
    }
  }

  // ------------- FOR SOS ------------- //

  // ------------- FOR FETCHING MY REPORT ------------- //
  Future<List<MyReport>> fetchReport() async {
    final user = await Storage.getData();
    String? token = user['token'];
    final response = await http.get(
      Uri.parse('$baseUrl/announcements'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> myReportList = jsonData['announcement'];
      return myReportList.map((json) => MyReport.fromJson(json)).toList();
    } else {
      log('The status code when fetching My Report is: ${response.statusCode}');
      throw Exception('Failed to load My Report');
    }
  }

  // ------------- FOR SUBMITING REPORT ------------- //
  Future<Map<String, dynamic>> submitReport(
    String priority,
    String location,
    String description,
    String evidence,
  ) async {
    final user = await Storage.getData();
    String? token = user['token'];
    final evidenceFile = File(evidence);
    if (!evidenceFile.existsSync()) {
      return {
        'statusCode': 400,
        'data': {'error': 'Evidence file does not exist.'},
      };
    }
    final uri = Uri.parse('$baseUrl/barangay-concern');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..fields['priority_type'] = priority
      ..fields['location'] = location
      ..fields['description'] = description
      ..files.add(await http.MultipartFile.fromPath(
        'evidence',
        evidenceFile.path,
      ));
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final Map<String, dynamic> responseData = jsonDecode(responseBody);

    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }
}
