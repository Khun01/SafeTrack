import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:safetrack/services/storage.dart';

class FeatureServices {
  final String baseUrl;

  FeatureServices({required this.baseUrl});

  
  // ------------- FOR GETTING ANNOUNCEMENT ------------- //

  // ------------- FOR GETTING CONTACTS ------------- //

  // ------------- FOR SOS ------------- //

  // ------------- FOR SUBMITING REPORT ------------- //
  Future<Map<String, dynamic>> submitReport(
    String title,
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
      ..fields['title'] = title
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
