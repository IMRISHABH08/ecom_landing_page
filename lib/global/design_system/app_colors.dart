import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF1A1A1A);
  static const Color backgroundLight = Color(0xFF2A2A2A);
  static const Color surface = Color(0xFF252525);
  static const Color cardBackground = Color(0xFF222222);

  static const Color yellow = Color(0xFFF5C518);
  static const Color yellowDark = Color(0xFFD4A800);
  static const Color green = Color(0xFF34C759);
  static const Color greenDark = Color(0xFF28A745);

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF8E8E93);
  static const Color greyLight = Color(0xFFAEAEB2);
  static const Color greyDark = Color(0xFF48484A);

  static const Color dotTexture = Color(0xFF2E2E2E);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2C2800), Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
    stops: [0.0, 0.4, 1.0],
  );

  static const LinearGradient brandTextGradient = LinearGradient(
    colors: [yellow, green],
  );
}
