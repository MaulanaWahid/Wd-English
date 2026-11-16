import 'package:flutter/material.dart';

import '../app_assets.dart';
import '../theme/app_theme.dart';

/// Kumpulan helper kecil agar seluruh tampilan tetap dibangun dari
/// ListView, ListTile, dan Image.
class TileKit {
  TileKit._();

  static RoundedRectangleBorder shape({
    double corners = 24,
    Color? borderColor,
  }) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(corners),
      side: BorderSide(
        color: borderColor ?? AppColors.ink.withValues(alpha: 0.07),
      ),
    );
  }

  static Widget art(String asset, double size, {double? width}) {
    return Image.asset(
      asset,
      width: width ?? size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }

  /// Jarak antar tile memakai gambar transparan agar tidak menambah
  /// jenis widget baru.
  static Widget gap(double height) {
    return Image.asset(
      AppAssets.spacer,
      width: double.infinity,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
