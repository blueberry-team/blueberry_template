import 'package:flutter/material.dart';

/// 카드 섹션을 표시하는 위젯
class CardSection extends StatelessWidget {
  /// 섹션 제목
  final String title;

  /// 섹션에 표시할 카드 위젯 목록
  final List<Widget> cards;

  /// CardSection 생성자
  const CardSection({super.key, required this.title, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ...cards,
      ],
    );
  }
}
