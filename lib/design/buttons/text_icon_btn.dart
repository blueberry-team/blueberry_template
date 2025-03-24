import 'package:flutter/material.dart';

/// 아이콘이 있는 텍스트 버튼 컴포넌트
class TextIconBtn extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 아이콘
  final IconData icon;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// TextIconBtn 생성자
  const TextIconBtn({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }
} 