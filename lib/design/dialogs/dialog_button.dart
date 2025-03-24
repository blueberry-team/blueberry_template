import 'package:flutter/material.dart';
import '../buttons/filled_btn.dart';

/// 다이얼로그 버튼을 표시하는 위젯
class DialogButton extends StatelessWidget {
  /// 버튼 제목
  final String title;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback onPressed;

  /// DialogButton 생성자
  const DialogButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: FilledBtn(
        text: title,
        onPressed: onPressed,
      ),
    );
  }
}
