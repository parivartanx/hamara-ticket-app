import 'package:flutter/material.dart';

@immutable
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  const CustomThemeExtension({
    required this.cardBackground,
    required this.customShadow,
    required this.gradientColors,
  });

  final Color cardBackground;
  final Shadow customShadow;
  final List<Color> gradientColors;

  static const light = CustomThemeExtension(
    cardBackground: Colors.white,
    customShadow: Shadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
    gradientColors: [Color(0xFF6750A4), Color(0xFF9080B5)],
  );

  static const dark = CustomThemeExtension(
    cardBackground: Color(0xFF1E1E1E),
    customShadow: Shadow(
      color: Colors.black26,
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
    gradientColors: [Color(0xFF9080B5), Color(0xFF6750A4)],
  );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? cardBackground,
    Shadow? customShadow,
    List<Color>? gradientColors,
  }) {
    return CustomThemeExtension(
      cardBackground: cardBackground ?? this.cardBackground,
      customShadow: customShadow ?? this.customShadow,
      gradientColors: gradientColors ?? this.gradientColors,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      customShadow: Shadow.lerp(customShadow, other.customShadow, t)!,
      gradientColors: [
        Color.lerp(gradientColors[0], other.gradientColors[0], t)!,
        Color.lerp(gradientColors[1], other.gradientColors[1], t)!,
      ],
    );
  }
}
