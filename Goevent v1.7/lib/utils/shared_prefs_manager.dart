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
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
        print('SharedPreferences initialized successfully');
      }
    } catch (e) {
      print('Failed to initialize SharedPreferences: $e');
    }
  }

  static Future<bool> _checkInitialized() async {
    if (_prefs == null) {
      // Instead of throwing an exception, try to reinitialize
      try {
        await init();
        if (_prefs == null) {
          print('SharedPrefsManager still not initialized after retry.');
          return false;
        }
      } catch (e) {
        print('Failed to reinitialize SharedPreferences: $e');
        return false;
      }
    }
    return true;
  }

  // Clear all preferences
  static Future<bool> clearAll() async {
    try {
      if (!await _checkInitialized()) return false;
      return await _prefs!.clear();
    } catch (e) {
      print('Error clearing preferences: $e');
      return false;
    }
  }

  // Token operations
  static Future<bool> setAccessToken(String token) async {
    try {
      if (!await _checkInitialized()) return false;
      return await _prefs!.setString(_accessTokenKey, token);
    } catch (e) {
      print('Error setting access token: $e');
      return false;
    }
  }

  static Future<String?> getAccessToken() async {
    try {
      if (!await _checkInitialized()) return null;
      return _prefs!.getString(_accessTokenKey);
    } catch (e) {
      print('Error getting access token: $e');
      return null;
    }
  }

  static Future<bool> setRefreshToken(String token) async {
    try {
      if (!await _checkInitialized()) return false;
      return await _prefs!.setString(_refreshTokenKey, token);
    } catch (e) {
      print('Error setting refresh token: $e');
      return false;
    }
  }

  static Future<String?> getRefreshToken() async {
    try {
      if (!await _checkInitialized()) return null;
      return _prefs!.getString(_refreshTokenKey);
    } catch (e) {
      print('Error getting refresh token: $e');
      return null;
    }
  }

  // User operations
  static Future<bool> setUser(User user) async {
    try {
      if (!await _checkInitialized()) return false;
      final String jsonString = json.encode(user.toJson());
      return await _prefs!.setString(_userKey, jsonString);
    } catch (e) {
      print('Error setting user: $e');
      return false;
    }
  }

  static Future<User?> getUser() async {
    try {
      if (!await _checkInitialized()) return null;
      final String? jsonString = _prefs!.getString(_userKey);
      if (jsonString == null) return null;
      return User.fromJson(json.decode(jsonString));
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Clear authentication data
  static Future<bool> clearAuthData() async {
    try {
      if (!await _checkInitialized()) return false;
      await Future.wait([
        _prefs!.remove(_userKey),
        _prefs!.remove(_accessTokenKey),
        _prefs!.remove(_refreshTokenKey),
      ]);
      return true;
    } catch (e) {
      print('Error clearing auth data: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      if (!await _checkInitialized()) return false;
      return _prefs!.containsKey(_accessTokenKey) &&
          _prefs!.getString(_accessTokenKey) != null;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }
}
