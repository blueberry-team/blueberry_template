import 'package:flutter/material.dart';
import 'app_color.dart';

/// 앱 전체에서 사용되는 테마 설정을 정의하는 클래스
class AppTheme {
  /// 라이트 모드 테마 설정을 반환합니다.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        error: AppColor.error,
        surface: AppColor.surface,
      ),
    );
  }

  /// 다크 모드 테마 설정을 반환합니다.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        error: AppColor.error,
        surface: Color(0xFF1E1E1E),
      ),
    );
  }
}
