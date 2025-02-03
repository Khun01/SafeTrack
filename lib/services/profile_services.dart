import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:safetrack/models/user.dart';
import 'package:safetrack/services/storage.dart';

class ProfileServices {
  final String baseUrl;

  ProfileServices({required this.baseUrl});

  Future<Map<String, dynamic>> verificationRequest(
    String name,
    String gender,
    String phoneNo,
    String address,
    String birthday,
    String emergencyContactName,
    String emergencyContactNo,
    String relationship,
    String barangayIdPath,
  ) async {
    final user = await Storage.getData();
    String? token = user['token'];
    final barangayIdFile = File(barangayIdPath);
    if (!barangayIdFile.existsSync()) {
      return {
        'statusCode': 400,
        'data': {'error': 'Barangay ID file does not exist.'},
      };
    }
    final uri = Uri.parse('$baseUrl/verification-request');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['full_name'] = name
      ..fields['gender'] = gender
      ..fields['phone_number'] = phoneNo
      ..fields['address'] = address
      ..fields['date_of_birth'] = birthday
      ..fields['emergency_contact_name'] = emergencyContactName
      ..fields['emergency_contact_number'] = emergencyContactNo
      ..fields['relationship'] = relationship
      ..files.add(await http.MultipartFile.fromPath(
        'barangay_id_image',
        barangayIdFile.path,
      ));
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final Map<String, dynamic> responseData = jsonDecode(responseBody);

    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<User> users() async {
    final user = await Storage.getData();
    String? id = user['id'];
    final response = await http.get(
      Uri.parse('$baseUrl/user/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> user = json.decode(response.body);
      log('Successfully retrieved user: $user');
      return User.fromJson(user);
    } else {
      log('The status code is: ${response.statusCode}');
      throw Exception('Failed to load duties');
    }
  }
}
