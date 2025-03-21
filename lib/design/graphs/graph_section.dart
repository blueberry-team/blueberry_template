import 'package:flutter/material.dart';

/// 그래프 섹션을 표시하는 위젯
class GraphSection extends StatelessWidget {
  /// 섹션 제목
  final String title;
  /// 섹션에 표시할 그래프 목록
  final List<Widget> graphs;

  /// GraphSection 생성자
  const GraphSection({
    super.key,
    required this.title,
    required this.graphs,
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
        ...graphs,
      ],
    );
  }
} 