import 'package:flutter/material.dart';

/// Palet warna hangat dengan aksen pastel ala buku stiker anak.
class AppColors {
  AppColors._();

  static const Color cream = Color(0xFFFFFAF1);
  static const Color white = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF25324A);
  static const Color inkSoft = Color(0xFF58657C);
  static const Color coral = Color(0xFFC94A2C);
  static const Color mint = Color(0xFFD9F4E7);
  static const Color peach = Color(0xFFFFE5D2);
  static const Color sky = Color(0xFFD9EDFF);
  static const Color lavender = Color(0xFFE9E1FF);
  static const Color butter = Color(0xFFFFF2C4);
  static const Color rose = Color(0xFFFFE1EA);
  static const Color lime = Color(0xFFE8F7C9);
  static const Color aqua = Color(0xFFD6F6F3);
}

/// Gaya teks Fredoka yang dipakai konsisten di seluruh aplikasi.
class AppType {
  AppType._();

  static TextStyle style({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink,
    double height = 1.25,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Fredoka',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Fredoka',
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coral,
        brightness: Brightness.light,
      ),
      splashFactory: InkRipple.splashFactory,
      visualDensity: VisualDensity.standard,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontFamily: 'Fredoka',
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: AppColors.ink,
        iconColor: AppColors.ink,
        minLeadingWidth: 36,
        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }
}
