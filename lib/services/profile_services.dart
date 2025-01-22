import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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
    // Convert the string (file path) into a File object
    final barangayIdFile = File(barangayIdPath);

    // Check if the file exists
    if (!barangayIdFile.existsSync()) {
      return {
        'statusCode': 400,
        'data': {'error': 'Barangay ID file does not exist.'},
      };
    }

    // Create a multipart request
    final uri = Uri.parse('$baseUrl/verification-request');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] =
          'Bearer 2|W3Nn5xZ7GfUDyNk7cZddsWR5WN44iTfNuGICmF9R559b5398'
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

    // Send the request and get the response
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final Map<String, dynamic> responseData = jsonDecode(responseBody);

    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }
}
