import 'package:flutter/material.dart';

/// 버튼 행을 표시하는 위젯
class ButtonRow extends StatelessWidget {
  /// 가로로 나열할 버튼 위젯 목록
  final List<Widget> buttons;

  /// ButtonRow 생성자
  const ButtonRow({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: buttons);
  }
}
