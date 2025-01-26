import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:safetrack/services/storage.dart';

class AuthServices {
  final String baseUrl;

  AuthServices({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<Map<String, dynamic>> register(String name, String email,
      String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
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

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('Forgot Password in services: ${response.statusCode} and ${response.body}');
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<Map<String, dynamic>> resetPassword(String email, String token,
      String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'otp': token,
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

  Future<Map<String, dynamic>> logout() async {
    final user = await Storage.getData();
    String? token = user['token'];
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }
}
