import 'package:flutter/material.dart';

/// 크기 조절 가능한 버튼 컴포넌트
class SizedBtn extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback? onPressed;

  /// 버튼 크기 (large, medium, small)
  final String size;

  /// SizedBtn 생성자
  const SizedBtn({
    super.key,
    required this.text,
    required this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: _getPaddingBySize(),
      ),
      child: Text(text),
    );
  }

  /// 크기에 따른 패딩 값을 반환
  EdgeInsetsGeometry _getPaddingBySize() {
    switch (size) {
      case 'large':
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      case 'small':
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case 'medium':
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }
} 