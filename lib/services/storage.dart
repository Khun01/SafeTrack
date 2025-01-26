import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const _storage = FlutterSecureStorage();
  static const _prefix = 'user_';

  static Future<String?> getField(String key) async {
    try {
      return await _storage.read(key: '$_prefix$key');
    } catch (e) {
      throw Exception('Failed to read $key from storage: $e');
    }
  }

  static Future<void> saveField(String key, String value) async {
    try {
      await _storage.write(key: '$_prefix$key', value: value);
    } catch (e) {
      throw Exception('Failed to write $key to storage: $e');
    }
  }

  static Future<void> deleteField(String key) async {
    try {
      await _storage.delete(key: '$_prefix$key');
    } catch (e) {
      throw Exception('Failed to delete $key from storage: $e');
    }
  }

  static Future<void> saveData({
    String? id,
    String? token,
  }) async {
    try {
      await Future.wait([
        saveField('id', id ?? ""),
        saveField('token', token ?? ""),
      ]);
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  static Future<Map<String, String?>> getData() async {
    try {
      final userData = await Future.wait([
        getField('id'),
        getField('token'),
      ]);
      return {
        'id': userData[0],
        'token': userData[1],
      };
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  static Future<void> deleteData() async {
    try {
      await Future.wait([
        deleteField('id'),
        deleteField('token'),
      ]);
    } catch (e) {
      throw Exception('Failed to delete user data: $e');
    }
  }
}
