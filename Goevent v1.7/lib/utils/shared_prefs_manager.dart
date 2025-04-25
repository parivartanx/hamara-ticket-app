import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SharedPrefsManager {
  // Singleton pattern
  static final SharedPrefsManager _instance = SharedPrefsManager._internal();
  factory SharedPrefsManager() => _instance;
  SharedPrefsManager._internal();

  static SharedPreferences? _prefs;

  // Keys for storing data
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool _checkInitialized() {
    if (_prefs == null) {
      throw Exception('SharedPrefsManager not initialized. Call init() first.');
    }
    return true;
  }

  // Clear all preferences
  static Future<bool> clearAll() async {
    _checkInitialized();
    return await _prefs!.clear();
  }

  // Token operations
  static Future<bool> setAccessToken(String token) async {
    _checkInitialized();
    return await _prefs!.setString(_accessTokenKey, token);
  }

  static String? getAccessToken() {
    _checkInitialized();
    return _prefs!.getString(_accessTokenKey);
  }

  static Future<bool> setRefreshToken(String token) async {
    _checkInitialized();
    return await _prefs!.setString(_refreshTokenKey, token);
  }

  static String? getRefreshToken() {
    _checkInitialized();
    return _prefs!.getString(_refreshTokenKey);
  }

  // Employee operations
  static Future<bool> setUser(User user) async {
    _checkInitialized();
    final String jsonString = json.encode(user.toJson());
    return await _prefs!.setString(_userKey, jsonString);
  }

  static User? getUser() {
    _checkInitialized();
    final String? jsonString = _prefs!.getString(_userKey);
    if (jsonString == null) return null;
    return User.fromJson(json.decode(jsonString));
  }

  // Clear authentication data
  static Future<void> clearAuthData() async {
    _checkInitialized();
    await Future.wait([
      _prefs!.remove(_userKey),
      _prefs!.remove(_accessTokenKey),
      _prefs!.remove(_refreshTokenKey),
    ]);
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    _checkInitialized();
    return _prefs!.containsKey(_accessTokenKey) &&
        _prefs!.getString(_accessTokenKey) != null;
  }
}
