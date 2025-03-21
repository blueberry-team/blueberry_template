import 'package:flutter/material.dart';

/// 선택 가능한 캘린더 카드 컴포넌트
class SelectableCalendarCard extends StatefulWidget {
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

  /// SelectableCalendarCard 생성자
  const SelectableCalendarCard({
    super.key,
    required this.title,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onDateChanged,
  });

  @override
  State<SelectableCalendarCard> createState() => _SelectableCalendarCardState();
}

/// SelectableCalendarCard의 상태 클래스
class _SelectableCalendarCardState extends State<SelectableCalendarCard> {
  /// 현재 선택된 날짜
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              onDateChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
                widget.onDateChanged?.call(date);
              },
            ),
            const SizedBox(height: 16),
            Text(
              '선택된 날짜: ${_selectedDate.toString().split(' ')[0]}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
