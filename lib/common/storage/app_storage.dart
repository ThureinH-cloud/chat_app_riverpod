import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  final String _tokenKey = "token";
  final String _userIdKey = "userId";
  final SharedPreferences _preferences = GetIt.I.get<SharedPreferences>();
  Future<void> saveToken(String token) async {
    await _preferences.setString(_tokenKey, token);
  }

  String getToken() {
    return _preferences.getString(_tokenKey) ?? "";
  }

  Future<void> saveUserId(String userId) async {
    await _preferences.setString(_userIdKey, userId);
  }

  String getUserId() {
    return _preferences.getString(_userIdKey) ?? "";
  }
}
