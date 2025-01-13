import 'package:flutter/material.dart';

class AppColors {
  // Define base colors
  static const Color primeryColor = Colors.white;
  static const Color darkPrimeryColor = Color(0xff2D2D3A);

  static const Color cardColor = Colors.white;
  static const Color darkCardColor = Color(0xff3d3d4e);

  static const Color textColor = Color(0xff2D2D3A);
  static const Color darkTextColor = Color(0xff5669FF);

  static const Color proColor = Color(0xff7e8ae0);
  static const Color darkProColor = Color(0xff393948);

  static const Color text1Color = Color(0xff2D2D3A);
  static const Color darkText1Color = Color(0xffDADADA);

  static const Color whiteColor = Colors.white;
  static const Color darkWhiteColor = Colors.black;

  static const Color buttonsColor = Color(0xff5669FF);
  static const Color darkButtonsColor = Color(0xff5669FF);

  static const Color buttonColor = Color(0xff5669FF);
  static const Color buttonBoldColor = Color(0xff2D2D3A);

  static const Color topColor = Color(0xff5669FF);
  static const Color darkTopColor = Color(0xff404052);

  static const Color darkBlackColor = Colors.black;
  static const Color blackColor = Colors.white;

  static const Color blueColor = Color(0xff00F8FF);
  static const Color darkBlueColor = Color(0xff2D2D3A);

  static const Color orangeColor = Color(0xffd6feff);
  static const Color darkOrangeColor = Color(0xff393948);

  static const Color pinkColor = Color(0xfff0f0f0);
  static const Color darkPinkColor = Color(0xff393948);

  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.white;

  // Define the MaterialColor for primary color
  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_primaryValue), // Base color
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  static const int _primaryValue = 0xFF5669FF; // Your base color value
}
