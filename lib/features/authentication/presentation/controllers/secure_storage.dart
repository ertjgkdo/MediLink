import 'package:medilink/utils/exporter.dart';

class SecureStorage {
  //flutter secure storage
  static const _storage =
      FlutterSecureStorage(wOptions: WindowsOptions.defaultOptions);

  // Save User Data
  static Future<void> saveUserInfo(Patient user) async {
    await _storage.write(key: 'user_id', value: user.id.toString());
    await _storage.write(key: 'auth_token', value: user.token);
    await _storage.write(key: 'username', value: user.name);
  }

  // Retrieve User ID
  static Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  // Retrieve Token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Retrieve Username
  static Future<String?> getUsername() async {
    return await _storage.read(key: 'username');
  }

  // Delete User Info (Logout)
  static Future<void> deleteUserInfo() async {
    await _storage.deleteAll(); // Clears all stored data
  }
}
