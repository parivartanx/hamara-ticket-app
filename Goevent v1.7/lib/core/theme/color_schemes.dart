import 'package:flutter/material.dart';

class AppColorScheme {
  static const seed = Color(0xFFD32651); // Your primary brand color

  static final light = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
    primary: const Color(0xFFD32651),
    onPrimary: Colors.white,
  );

  static final dark = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.dark,
    primary: const Color(0xFFD32651),
    onPrimary: Colors.grey.shade50,
  );

  // Custom colors that aren't part of the material color scheme
  static final custom = _CustomColors();
}

class _CustomColors {
  final success = const Color(0xFF4CAF50);
  final warning = const Color(0xFFFFA000);
  final error = const Color(0xFFE53935);
  final info = const Color(0xFF2196F3);
}
