import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',

    // Scaffold 테마
    scaffoldBackgroundColor: Palette.surface, // Scaffold BG

    // 앱 전체적인 테마
    colorScheme: const ColorScheme.light(
      primary: Palette.primary,
      onPrimary: Palette.container,
      secondary: Palette.secondary,
      onSecondary: Palette.onSurface,
      surface: Palette.surface,
      onSurface: Palette.onSurface,
      onSurfaceVariant: Palette.onSurfaceVariant,
      error: Palette.error,
      onError: Palette.surface,
    ),
  );
}
