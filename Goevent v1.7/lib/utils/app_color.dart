import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryValue = 0xFFD32651; // Base red color

  // Primary MaterialColor swatch
  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF9E0E7),  // Lightest shade
      100: Color(0xFFF0B3C3),
      200: Color(0xFFE68099),
      300: Color(0xFFDB4D70),
      400: Color(0xFFD32651),
      500: Color(_primaryValue), // Base color
      600: Color(0xFFBE003D),
      700: Color(0xFFB30036),
      800: Color(0xFFA90030),
      900: Color(0xFF950024),  // Darkest shade
    },
  );

  // Theme colors based on primary color
  static const Color primeryColor = Colors.white;
  static const Color darkPrimeryColor = Color(_primaryValue);

  static const Color cardColor = Colors.white;
  static const Color darkCardColor = Color(0xFF2F0011); // Darker variant of primary

  static const Color textColor = Color(_primaryValue);
  static const Color darkTextColor = Color(0xFFF0B3C3); // Light variant of primary

  static const Color proColor = Color(0xFFE68099); // Primary 200
  static const Color darkProColor = Color(0xFF2F0011);

  static const Color text1Color = Color(_primaryValue);
  static const Color darkText1Color = Color(0xFFDADADA);

  static const Color whiteColor = Colors.white;
  static const Color darkWhiteColor = Colors.black;

  static const Color buttonsColor = Color(_primaryValue);
  static const Color darkButtonsColor = Color(_primaryValue);

  static const Color buttonColor = Color(_primaryValue);
  static const Color buttonBoldColor = Color(0xFF2F0011);

  static const Color topColor = Color(_primaryValue);
  static const Color darkTopColor = Color(0xFF2F0011);

  static const Color darkBlackColor = Colors.black;
  static const Color blackColor = Colors.white;

  static const Color blueColor = Color(0xFFF9E0E7); // Primary 50
  static const Color darkBlueColor = Color(_primaryValue);

  static const Color orangeColor = Color(0xFFF0B3C3); // Primary 100
  static const Color darkOrangeColor = Color(0xFF2F0011);

  static const Color pinkColor = Color(0xFFF9E0E7); // Primary 50
  static const Color darkPinkColor = Color(0xFF2F0011);

  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.white;
}
