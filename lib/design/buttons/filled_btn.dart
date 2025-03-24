import 'package:flutter/material.dart';

/// 채우기 버튼 컴포넌트
class FilledBtn extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// FilledBtn 생성자
  const FilledBtn({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text),
    );
  }
}
