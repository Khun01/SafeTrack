import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const _storage = FlutterSecureStorage();
  static const _prefix = 'user_';

  static Future<void> saveField(String key, String value) async {
    await _storage.write(key: '$_prefix$key', value: value);
  }

  static Future<String?> getField(String key) async {
    return await _storage.read(key: '$_prefix$key');
  }

  static Future<void> deleteField(String key) async {
    await _storage.delete(key: '$_prefix$key');
  }

  static Future<void> saveData({
    String? id,
    String? token,
  }) async {
    await Future.wait([
      saveField('id', id ?? ""),
      saveField('token', token ?? ""),
    ]);
  }

  static Future<Map<String, String?>> getData() async {
    final userData = await Future.wait([
      getField('id'),
      getField('token'),
    ]);
    final data = {
      'id': userData[0],
      'token': userData[1],
    };
    return data;
  }

  static Future<void> deleteData() async {
    await Future.wait([
      deleteField('id'),
      deleteField('token'),
    ]);
  }
}
