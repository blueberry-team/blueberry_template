import 'package:flutter/material.dart';

/// 앱 전체에서 사용되는 색상을 정의하는 ThemeExtension
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// 생성자
  const AppColors({
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.secondary,
    required this.error,
    required this.success,
    required this.warning,
  });

  /// Surface 배경색
  final Color surface;

  /// 기본 텍스트 색상
  final Color textPrimary;

  /// 보조 텍스트 색상
  final Color textSecondary;

  /// 주요 강조 색상
  final Color primary;

  /// 보조 강조 색상
  final Color secondary;

  /// 오류 상태 표시 색상
  final Color error;

  /// 성공 상태 표시 색상
  final Color success;

  /// 경고 상태 표시 색상
  final Color warning;

  /// 밝은 테마용 기본 컬러 정의
  static const light = AppColors(
    surface: Color(0xFFF5F5F5),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF666666),
    primary: Color(0xFF2196F3),
    secondary: Color(0xFF03DAC6),
    error: Color(0xFFB00020),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFC107),
  );

  /// 다크 테마용 기본 컬러 정의
  static const dark = AppColors(
    surface: Color(0xFF1E1E1E),
    textPrimary: Color(0xFFE0E0E0),
    textSecondary: Color(0xFFB0B0B0),
    primary: Color(0xFF64B5F6),
    secondary: Color(0xFF26C6DA),
    error: Color(0xFFCF6679),
    success: Color(0xFF81C784),
    warning: Color(0xFFFFD54F),
  );

  @override
  AppColors copyWith({
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? primary,
    Color? secondary,
    Color? error,
    Color? success,
    Color? warning,
  }) => AppColors(
    surface: surface ?? this.surface,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    error: error ?? this.error,
    success: success ?? this.success,
    warning: warning ?? this.warning,
  );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

/// BuildContext 확장을 통해 AppColors에 쉽게 접근할 수 있도록 합니다.
extension AppColorsExtension on BuildContext {
  /// AppColors에 쉽게 접근하기 위한 getter
  AppColors get colors {
    return Theme.of(this).extension<AppColors>() ?? AppColors.light;
  }
}
