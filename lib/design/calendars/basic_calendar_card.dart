import 'package:flutter/material.dart';

/// 기본 캘린더 카드 컴포넌트
class BasicCalendarCard extends StatelessWidget {
  /// 카드 제목
  final String title;
  /// 초기 날짜
  final DateTime initialDate;
  /// 시작 날짜
  final DateTime firstDate;
  /// 종료 날짜
  final DateTime lastDate;
  /// 날짜 변경 이벤트 콜백
  final ValueChanged<DateTime>? onDateChanged;

  /// BasicCalendarCard 생성자
  const BasicCalendarCard({
    super.key,
    required this.title,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            CalendarDatePicker(
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateChanged: onDateChanged ?? (date) {},
            ),
          ],
        ),
      ),
    );
  }
} 