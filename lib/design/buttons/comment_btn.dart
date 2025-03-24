import 'package:flutter/material.dart';

/// 코멘트 버튼 컴포넌트
class CommentBtn extends StatelessWidget {
  /// 코멘트 개수
  final int commentCount;
  
  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// CommentButton 생성자
  const CommentBtn({
    super.key,
    required this.commentCount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: const Icon(Icons.comment_outlined, size: 18),
      label: Text('$commentCount'),
    );
  }
} 