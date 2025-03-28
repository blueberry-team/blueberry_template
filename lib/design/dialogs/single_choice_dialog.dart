import 'package:flutter/material.dart';

/// 단일 항목 선택 다이얼로그 컴포넌트
class SingleChoiceDialog extends StatefulWidget {
  /// 다이얼로그 제목
  final String title;

  /// 선택 가능한 옵션 목록
  final List<String> options;

  /// 취소 버튼 콜백 함수
  final VoidCallback? onCancel;

  /// 선택 완료 시 호출될 콜백 함수
  final ValueChanged<String>? onConfirm;

  /// SingleChoiceDialog 생성자
  const SingleChoiceDialog({
    super.key,
    required this.title,
    required this.options,
    this.onCancel,
    this.onConfirm,
  });

  @override
  State<SingleChoiceDialog> createState() => _SingleChoiceDialogState();
}

class _SingleChoiceDialogState extends State<SingleChoiceDialog> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            widget.options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              );
            }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel ?? () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed:
              selectedValue == null
                  ? null
                  : () {
                    widget.onConfirm?.call(selectedValue!);
                    Navigator.pop(context);
                  },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
