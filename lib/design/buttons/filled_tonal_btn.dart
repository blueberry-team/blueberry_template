import 'package:flutter/material.dart';

/// 톤 채우기 버튼 컴포넌트
class FilledTonalBtn extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// FilledTonalBtn 생성자
  const FilledTonalBtn({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      child: Text(text),
    );
  }
} 