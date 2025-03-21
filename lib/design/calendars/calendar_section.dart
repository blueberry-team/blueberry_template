import 'package:flutter/material.dart';

/// 캘린더 섹션을 표시하는 위젯
class CalendarSection extends StatelessWidget {
  /// 섹션 제목
  final String title;

  /// 섹션에 표시할 캘린더 위젯 목록
  final List<Widget> calendars;

  /// CalendarSection 생성자
  const CalendarSection({
    super.key,
    required this.title,
    required this.calendars,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ...calendars,
      ],
    );
  }
}
