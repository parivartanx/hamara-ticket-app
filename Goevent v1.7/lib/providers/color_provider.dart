import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_color.dart';

// Define the state
class ColorState {
  final bool isDark;

  const ColorState({required this.isDark});

  // Getter methods for colors based on the theme
  Color get primaryColor => isDark ? AppColors.darkPrimeryColor : AppColors.primeryColor;
  Color get cardColor => isDark ? AppColors.darkCardColor : AppColors.cardColor;
  Color get textColor => isDark ? AppColors.darkTextColor : AppColors.textColor;
  Color get proColor => isDark ? AppColors.darkProColor : AppColors.proColor;
  Color get text1Color => isDark ? AppColors.darkText1Color : AppColors.text1Color;
  Color get whiteColor => isDark ? AppColors.whiteColor : AppColors.darkWhiteColor;
  Color get buttonsColor => isDark ? AppColors.darkButtonsColor : AppColors.buttonsColor;
  Color get buttonColor => isDark ? AppColors.buttonBoldColor : AppColors.buttonColor;
  Color get topColor => isDark ? AppColors.darkTopColor : AppColors.topColor;
  Color get darksColor => isDark ? AppColors.blackColor : AppColors.darkBlackColor;
  Color get blueColor => isDark ? AppColors.darkBlueColor : AppColors.blueColor;
  Color get orangeColor => isDark ? AppColors.darkOrangeColor : AppColors.orangeColor;
  Color get pinkColor => isDark ? AppColors.darkPinkColor : AppColors.pinkColor;
  Color get blackColor => isDark ? AppColors.darkWhiteColor : AppColors.whiteColor;

  // Copy with method for state updates
  ColorState copyWith({bool? isDark}) {
    return ColorState(isDark: isDark ?? this.isDark);
  }
}

// Define the StateNotifier
class ColorNotifier extends StateNotifier<ColorState> {
  ColorNotifier() : super(const ColorState(isDark: false));

  // Toggle between light and dark mode
  void toggleTheme() {
    state = state.copyWith(isDark: !state.isDark);
  }

  // Set dark mode explicitly
  void setDarkMode(bool value) {
    state = state.copyWith(isDark: value);
  }

   void getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      setDarkMode(false);
    } else {
     setDarkMode(previusstate);
    }
  }
}

// Define the provider
final colorProvider = StateNotifierProvider<ColorNotifier, ColorState>((ref) {
  return ColorNotifier();
});

