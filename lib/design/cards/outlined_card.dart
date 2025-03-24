import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';

/// 테두리가 있는 카드 컴포넌트
class OutlinedCard extends StatelessWidget {
  /// 카드 제목
  final String title;

  /// 카드 설명
  final String description;

  /// 테두리가 있는 카드 생성자
  const OutlinedCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.titleMedium),
            const SizedBox(height: 8),
            Text(description, style: AppTypography.bodyMedium),
          ],
        ),
      ),
    );
  }
}
