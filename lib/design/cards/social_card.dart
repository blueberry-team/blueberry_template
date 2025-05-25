import 'package:flutter/material.dart';
import '../../theme/app_typography.dart';
import '../buttons/like_btn.dart';
import '../buttons/comment_btn.dart';

/// 좋아요 및 코멘트 기능이 있는 소셜 카드 컴포넌트
class SocialCard extends StatelessWidget {
  /// 카드 제목
  final String title;

  /// 카드 설명
  final String description;

  /// 좋아요 개수
  final int likeCount;

  /// 좋아요 상태 (활성화 여부)
  final bool isLiked;

  /// 코멘트 개수
  final int commentCount;

  /// 좋아요 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onLikePressed;

  /// 코멘트 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onCommentPressed;

  /// SocialCard 생성자
  const SocialCard({
    super.key,
    required this.title,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    this.isLiked = false,
    this.onLikePressed,
    this.onCommentPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.titleMedium),
            const SizedBox(height: 8),
            Text(description, style: AppTypography.bodyMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                LikeBtn(
                  likeCount: likeCount,
                  isLiked: isLiked,
                  onPressed: onLikePressed,
                ),
                const SizedBox(width: 8),
                CommentBtn(
                  commentCount: commentCount,
                  onPressed: onCommentPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 이미지가 있는 소셜 카드 컴포넌트
class SocialCardWithImage extends StatelessWidget {
  /// 카드 제목
  final String title;

  /// 카드 설명
  final String description;

  /// 이미지 URL
  final String imageUrl;

  /// 좋아요 개수
  final int likeCount;

  /// 좋아요 상태 (활성화 여부)
  final bool isLiked;

  /// 코멘트 개수
  final int commentCount;

  /// 좋아요 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onLikePressed;

  /// 코멘트 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onCommentPressed;

  /// SocialCardWithImage 생성자
  const SocialCardWithImage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likeCount,
    required this.commentCount,
    this.isLiked = false,
    this.onLikePressed,
    this.onCommentPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 섹션
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                );
              },
            ),
          ),
          // 내용 섹션
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleMedium),
                const SizedBox(height: 8),
                Text(description, style: AppTypography.bodyMedium),
                const SizedBox(height: 16),
                Row(
                  children: [
                    LikeBtn(
                      likeCount: likeCount,
                      isLiked: isLiked,
                      onPressed: onLikePressed,
                    ),
                    const SizedBox(width: 8),
                    CommentBtn(
                      commentCount: commentCount,
                      onPressed: onCommentPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
