import 'package:flutter/material.dart';

/// 아이콘이 있는 채우기 버튼 컴포넌트
class FilledIconBtn extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 아이콘
  final IconData icon;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// FilledIconBtn 생성자
  const FilledIconBtn({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, size: 18),
      label: Text(text),
    );
  }
} 