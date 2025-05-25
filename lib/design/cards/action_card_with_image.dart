import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../buttons/text_btn.dart';
import '../buttons/filled_btn.dart';

/// 이미지와 액션 버튼이 포함된 카드 컴포넌트
class ActionCardWithImage extends StatelessWidget {
  /// 카드 제목
  final String title;

  /// 카드 설명
  final String description;

  /// 이미지 URL
  final String imageUrl;

  /// 취소 버튼 콜백 함수
  final VoidCallback? onCancel;

  /// 확인 버튼 콜백 함수
  final VoidCallback? onConfirm;

  /// 이미지와 액션 버튼이 포함된 카드 생성자
  const ActionCardWithImage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
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
                Expanded(child: TextBtn(text: '취소', onPressed: onCancel)),
                const SizedBox(width: 8),
                Expanded(child: FilledBtn(text: '확인', onPressed: onConfirm)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
