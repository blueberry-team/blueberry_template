// 위젯 테스트를 위한 기본 Flutter 코드입니다.
//
// 테스트에서 위젯과 상호작용하려면 flutter_test 패키지의 WidgetTester 
// 유틸리티를 사용하세요. 예를 들어, 탭이나 스크롤 제스처를 보낼 수 있고,
// 위젯 트리에서 자식 위젯을 찾고, 텍스트를 읽고, 위젯 속성 값이 올바른지 확인할 수 있습니다.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:template/main.dart';
import 'package:template/screens/design_system_screen.dart';

void main() {
  /// 디자인 시스템 앱의 기본적인 렌더링 테스트
  testWidgets('디자인 시스템 앱 기본 렌더링 테스트', (WidgetTester tester) async {
    // 앱을 빌드하고 프레임을 트리거합니다.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 디자인 시스템 화면이 렌더링되는지 확인합니다.
    expect(find.byType(DesignSystemScreen), findsOneWidget);
    
    // 앱바 타이틀이 올바르게 표시되는지 확인합니다.
    expect(find.text('디자인 시스템'), findsOneWidget);
    
    // 테마 변경 버튼이 있는지 확인합니다.
    expect(find.byType(IconButton), findsOneWidget);
    
    // 네비게이션 카드가 표시되는지 확인합니다.
    expect(find.byType(Card), findsWidgets);
    expect(find.text('색상 시스템'), findsOneWidget);
  });
}
