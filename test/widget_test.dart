import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:template/main.dart';
import 'package:template/screens/sample_screen.dart';

void main() {
  /// Blueberry Template 앱 기본 렌더링 테스트
  testWidgets('기본 렌더링 테스트', (WidgetTester tester) async {
    // 앱을 빌드하고 프레임을 트리거합니다.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 홈 스크린이 렌더링되는지 확인합니다.
    expect(find.byType(SampleScreen), findsOneWidget);
  });

  /// 테마 전환 테스트
  testWidgets('테마 전환 버튼 동작 테스트', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 테마 전환 버튼 찾기
    final themeButton = find.byIcon(Icons.light_mode);
    expect(themeButton, findsOneWidget);

    // 버튼 탭
    await tester.tap(themeButton);
    await tester.pumpAndSettle();

    // 아이콘이 변경되었는지 확인
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
}
