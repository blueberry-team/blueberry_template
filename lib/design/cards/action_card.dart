import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../buttons/text_btn.dart';
import '../buttons/filled_btn.dart';

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
                Text(title, style: AppTypography.titleMedium),
                const SizedBox(height: 8),
                Text(description, style: AppTypography.bodyMedium),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextBtn(
                    text: '취소',
                    onPressed: onCancel,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledBtn(
                    text: '확인',
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
