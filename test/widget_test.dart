import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/features/todo/screens/sample_screen.dart';
import 'package:template/main.dart';

void main() {
  testWidgets('앱이 정상적으로 렌더링된다', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    expect(find.byType(SampleScreen), findsOneWidget);
  });

  testWidgets('테마 전환 버튼이 동작한다', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
}
