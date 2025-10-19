import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/features/todo/screens/sample_screen.dart';

void main() {
  testWidgets('앱이 정상적으로 렌더링된다', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: SampleScreen()),
      ),
    );

    expect(find.byType(SampleScreen), findsOneWidget);
  });
}
