import 'package:flutter/material.dart';

/// 범위 선택 캘린더 카드 컴포넌트
class RangeCalendarCard extends StatefulWidget {
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

  /// 선택 가능한 날짜 필터링 함수
  final bool Function(DateTime)? selectableDayPredicate;

  /// 캘린더 설명
  final String description;

  /// RangeCalendarCard 생성자
  const RangeCalendarCard({
    super.key,
    required this.title,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onDateChanged,
    this.selectableDayPredicate,
    required this.description,
  });

  @override
  State<RangeCalendarCard> createState() => _RangeCalendarCardState();
}

/// RangeCalendarCard의 상태 클래스
class _RangeCalendarCardState extends State<RangeCalendarCard> {
  /// 현재 포커스된 날짜
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.initialDate;
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
              initialDate: _focusedDate,
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              onDateChanged: (date) {
                setState(() {
                  _focusedDate = date;
                });
                widget.onDateChanged?.call(date);
              },
              selectableDayPredicate: widget.selectableDayPredicate,
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
