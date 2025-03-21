import 'package:flutter/material.dart';

/// 다이얼로그 섹션을 표시하는 위젯
class DialogSection extends StatelessWidget {
  /// 섹션 제목
  final String title;
  /// 섹션에 표시할 버튼 목록
  final List<Widget> buttons;

  /// DialogSection 생성자
  const DialogSection({
    super.key,
    required this.title,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...buttons,
      ],
    );
  }
} 