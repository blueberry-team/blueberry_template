import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 테마 모드 상태를 관리하는 프로바이더
final themeModeNotifierProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
      return ThemeModeNotifier();
    });

/// 테마 모드 상태 관리 클래스
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  /// ThemeModeNotifier 생성자
  ThemeModeNotifier() : super(ThemeMode.dark);

  /// 테마 모드를 토글하는 메소드
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
