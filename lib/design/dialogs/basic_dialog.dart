import 'package:flutter/material.dart';
import '../buttons/text_btn.dart';
import '../buttons/filled_btn.dart';

/// 기본 다이얼로그 컴포넌트
class BasicDialog extends StatelessWidget {
  /// 다이얼로그 제목
  final String title;

  /// 다이얼로그 내용
  final String content;

  /// 취소 버튼 콜백 함수
  final VoidCallback? onCancel;

  /// 확인 버튼 콜백 함수
  final VoidCallback? onConfirm;

  /// BasicDialog 생성자
  const BasicDialog({
    super.key,
    required this.title,
    required this.content,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(title),
      content: Text(content),
      actions: [
        TextBtn(
          text: '취소',
          onPressed: onCancel ?? () => Navigator.pop(context),
        ),
        FilledBtn(
          text: '확인',
          onPressed: onConfirm ?? () => Navigator.pop(context),
        ),
      ],
    );
  }
}
