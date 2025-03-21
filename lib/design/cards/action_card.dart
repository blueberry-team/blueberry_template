import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';

/// 액션 버튼이 포함된 카드 컴포넌트
class ActionCard extends StatelessWidget {
  /// 카드 제목
  final String title;
  /// 카드 설명
  final String description;
  /// 취소 버튼 콜백 함수
  final VoidCallback? onCancel;
  /// 확인 버튼 콜백 함수
  final VoidCallback? onConfirm;

  /// 액션 카드 생성자
  const ActionCard({
    super.key,
    required this.title,
    required this.description,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8),
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text('취소'),
                ),
                FilledButton(
                  onPressed: onConfirm,
                  child: const Text('확인'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 