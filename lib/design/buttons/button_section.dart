import 'package:flutter/material.dart';

/// 버튼 섹션을 표시하는 위젯
class ButtonSection extends StatelessWidget {
  /// 섹션 제목
  final String title;

  /// 섹션에 표시할 버튼 위젯 목록
  final List<Widget> buttons;

  /// ButtonSection 생성자
  const ButtonSection({super.key, required this.title, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ...buttons,
      ],
    );
  }
}
