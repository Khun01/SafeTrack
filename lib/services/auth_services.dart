import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthServices {
  final String baseUrl;

  AuthServices({required this.baseUrl});

  Future<Map<String, dynamic>> register(String name, String email, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }
}