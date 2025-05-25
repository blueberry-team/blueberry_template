import 'package:flutter/material.dart';

/// 앱 전체에서 사용되는 색상 상수를 정의하는 클래스
class AppColor {
  /// 테두리에 사용되는 색상
  static const Color border = Color(0xFFBDBDBD);

  /// 기본 텍스트 색상
  static const Color textPrimary = Color(0xFF000000);

  /// 보조 텍스트 색상
  static const Color textSecondary = Color(0xFF666666);

  /// 표면 색상
  static const Color surface = Color(0xFFEDEDED);

  /// 다크 모드에서 카드 배경색
  static const Color darkSurface = Color(0xFF000000);

  /// 주요 강조 색상 (기본 버튼)
  static const Color primary = Color(0xFF892CDC); // 밝은 보라색

  /// 보조 강조 색상 (보조 버튼)
  static const Color secondary = Color(0xFF52057B); // 진한 보라

  /// 오류 상태 표시 색상
  static const Color error = Color(0xFFDC3545); // 빨간색 유지

  /// 성공 상태 표시 색상
  static const Color success = Color(0xFF28A745); // 초록색 유지

  /// 경고 상태 표시 색상
  static const Color warning = Color(0xFFFFC107);

  /// 정보 상태 표시 색상
  static const Color info = Color(0xFF2196F3);

  /// 텍스트 버튼 색상
  static const Color textBtn = Color(0xFFBC6FF1); // 연한 보라색
}
