import 'package:flutter/material.dart';
import '../buttons/text_btn.dart';
import '../buttons/filled_btn.dart';

/// 다중 항목 선택 다이얼로그 컴포넌트
class MultiChoiceDialog extends StatefulWidget {
  /// 다이얼로그 제목
  final String title;

  /// 선택 가능한 옵션 목록
  final List<String> options;

  /// 취소 버튼 콜백 함수
  final VoidCallback? onCancel;

  /// 선택 완료 시 호출될 콜백 함수
  final ValueChanged<List<String>>? onConfirm;

  /// MultiChoiceDialog 생성자
  const MultiChoiceDialog({
    super.key,
    required this.title,
    required this.options,
    this.onCancel,
    this.onConfirm,
  });

  @override
  State<MultiChoiceDialog> createState() => _MultiChoiceDialogState();
}

class _MultiChoiceDialogState extends State<MultiChoiceDialog> {
  final Set<String> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            widget.options.map((option) {
              return CheckboxListTile(
                title: Text(option),
                value: selectedValues.contains(option),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedValues.add(option);
                    } else {
                      selectedValues.remove(option);
                    }
                  });
                },
              );
            }).toList(),
      ),
      actions: [
        TextBtn(
          text: '취소',
          onPressed: widget.onCancel ?? () => Navigator.pop(context),
        ),
        FilledBtn(
          text: '확인',
          onPressed:
              selectedValues.isEmpty
                  ? null
                  : () {
                    widget.onConfirm?.call(selectedValues.toList());
                    Navigator.pop(context);
                  },
        ),
      ],
    );
  }
}
