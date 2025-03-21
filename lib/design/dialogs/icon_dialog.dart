import 'package:flutter/material.dart';

/// 아이콘이 포함된 다이얼로그 컴포넌트
class IconDialog extends StatelessWidget {
  /// 다이얼로그 제목
  final String title;
  /// 다이얼로그 내용
  final String content;
  /// 아이콘 데이터
  final IconData icon;
  /// 아이콘 색상
  final Color? iconColor;
  /// 취소 버튼 콜백 함수
  final VoidCallback? onCancel;
  /// 확인 버튼 콜백 함수
  final VoidCallback? onConfirm;

  /// IconDialog 생성자
  const IconDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.iconColor,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: onConfirm ?? () => Navigator.pop(context),
          child: const Text('확인'),
        ),
      ],
    );
  }
} 