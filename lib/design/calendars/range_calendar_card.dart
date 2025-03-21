import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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

  /// 날짜 범위 변경 이벤트 콜백
  final void Function(DateTime? start, DateTime? end)? onRangeChanged;

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
    this.onRangeChanged,
    this.selectableDayPredicate,
    required this.description,
  });

  @override
  State<RangeCalendarCard> createState() => _RangeCalendarCardState();
}

/// RangeCalendarCard의 상태 클래스
class _RangeCalendarCardState extends State<RangeCalendarCard> {
  /// 선택된 시작일
  DateTime? _rangeStart;

  /// 선택된 종료일
  DateTime? _rangeEnd;

  /// 현재 포커스된 날짜
  late DateTime _focusedDay;

  // 날짜 포맷터
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate;
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

            // 테이블 캘린더 위젯 사용
            TableCalendar(
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                // 시작일과 종료일이 아닌 경우 선택된 상태로 표시하지 않음
                return false;
              },
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: CalendarFormat.month,
              rangeSelectionMode: RangeSelectionMode.enforced,
              enabledDayPredicate: widget.selectableDayPredicate,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                });
                widget.onRangeChanged?.call(start, end);
              },
              calendarStyle: CalendarStyle(
                // 범위 내 날짜 스타일 지정
                rangeHighlightColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha(50),
                rangeStartDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                // 주말 스타일
                weekendTextStyle: const TextStyle(color: Colors.red),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: Theme.of(context).textTheme.titleMedium!,
              ),
            ),

            const SizedBox(height: 16),

            // 선택된 범위 표시
            _rangeStart != null
                ? Text(
                  '시작일: ${_dateFormat.format(_rangeStart!)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
                : Text(
                  '시작일: 선택 안됨',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            const SizedBox(height: 8),
            _rangeEnd != null
                ? Text(
                  '종료일: ${_dateFormat.format(_rangeEnd!)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
                : Text(
                  '종료일: 선택 안됨',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

            if (_rangeStart != null && _rangeEnd != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '선택 기간: ${_rangeEnd!.difference(_rangeStart!).inDays + 1}일',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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

  /// 같은 날짜인지 확인하는 헬퍼 메서드
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
