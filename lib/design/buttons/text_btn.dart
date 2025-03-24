import 'package:flutter/material.dart';

/// 텍스트 버튼 컴포넌트
class TextBtn extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// TextBtn 생성자
  const TextBtn({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(text),
    );
  }
} 