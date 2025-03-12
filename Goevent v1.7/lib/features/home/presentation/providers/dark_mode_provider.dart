import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(false) {
    _initDarkMode();
  }

  Future<void> _initDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("setIsDark") ?? false;
    state = isDark;
  }

  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("setIsDark", isDark);
    state = isDark;
  }
}