import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';

/// 기본 카드 컴포넌트
class BasicCard extends StatelessWidget {
  /// 카드 제목
  final String title;

  /// 카드 설명
  final String description;

  /// 기본 카드 생성자
  const BasicCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.titleLarge),
            const SizedBox(height: 8),
            Text(description, style: AppTypography.bodyMedium),
          ],
        ),
      ),
    );
  }
}
