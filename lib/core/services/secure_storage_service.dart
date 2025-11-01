import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _keyUserToken = 'user_token';
  static const _keyFcmToken = 'fcm_token';
  static const _keyUserData = 'user_data';

  Future<void> saveToken(String token) async =>
      _storage.write(key: _keyUserToken, value: token);

  Future<String?> getToken() async => _storage.read(key: _keyUserToken);

  Future<void> saveFcmToken(String fcmToken) async =>
      _storage.write(key: _keyFcmToken, value: fcmToken);

  Future<String?> getFcmToken() async => _storage.read(key: _keyFcmToken);

  Future<void> saveUserData(String userJson) async =>
      _storage.write(key: _keyUserData, value: userJson);

  Future<String?> getUserData() async => _storage.read(key: _keyUserData);

  Future<void> clear() async => _storage.deleteAll();

  /// ✅ Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    final userData = await _storage.read(key: _keyUserData);

    return userData != null && userData.isNotEmpty;
  }
}
