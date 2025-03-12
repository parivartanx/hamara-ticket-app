import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'custom_theme_extensions.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: AppColorScheme.light,
        extensions: const [CustomThemeExtension.light],
        // Additional theme configurations
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorScheme.light.primary,
          foregroundColor: AppColorScheme.light.onPrimary,
        ),
        cardTheme: CardTheme(
          color: CustomThemeExtension.light.cardBackground,
          elevation: 2,
        ),
        // Add more component themes as needed
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: AppColorScheme.dark,
        extensions: const [CustomThemeExtension.dark],
        // Additional theme configurations
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorScheme.dark.primary,
          foregroundColor: AppColorScheme.dark.onPrimary,
        ),
        cardTheme: CardTheme(
          color: CustomThemeExtension.dark.cardBackground,
          elevation: 2,
        ),
        // Add more component themes as needed
      );
}
