import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';

/// 이미지가 포함된 기본 카드 컴포넌트
class BasicCardWithImage extends StatelessWidget {
  /// 카드 제목
  final String title;
  /// 카드 설명
  final String description;
  /// 이미지 URL
  final String imageUrl;

  /// 이미지가 포함된 기본 카드 생성자
  const BasicCardWithImage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
        ],
      ),
    );
  }
} 