import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textColor;
  final Color iconColor;

  ThemeState({
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.textColor,
    required this.iconColor,
  });

  ThemeState copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? textColor,
    Color? iconColor,
  }) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        onBackground: textColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: iconColor,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor),
      ),
    );
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
      : super(ThemeState(
          primaryColor: const Color(0xFFF2114D),
          secondaryColor: const Color(0xFFFF5D56),
          accentColor: const Color(0xFFF2114D),
          backgroundColor: Colors.white,
          surfaceColor: Colors.white,
          textColor: Colors.black87,
          iconColor: Colors.black87,
        ));

  void updateTheme(Color primary, Color secondary) {
    // Animate to new colors
    _animateColors(
      primaryColor: primary,
      secondaryColor: secondary,
      accentColor: primary,
    );
  }

  void _animateColors({
    required Color primaryColor,
    required Color secondaryColor,
    required Color accentColor,
  }) {
    // Create a new state with the target colors
    final newState = state.copyWith(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      accentColor: accentColor,
    );

    // Update the state
    state = newState;
  }
}
