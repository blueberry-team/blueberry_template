import 'package:flutter/material.dart';
import '../design/calendars/calendar_section.dart';
import '../design/calendars/basic_calendar_card.dart';
import '../design/calendars/selectable_calendar_card.dart';
import '../design/calendars/range_calendar_card.dart';

/// 다양한 종류의 캘린더 화면을 표시하는 화면
class CalendarScreen extends StatefulWidget {
  /// CalendarScreen 생성자
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

/// CalendarScreen의 상태 클래스
class _CalendarScreenState extends State<CalendarScreen> {
  /// 선택된 날짜
  DateTime _selectedDate = DateTime.now();

  /// 포커스된 날짜
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캘린더')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CalendarSection(
                  title: '기본 캘린더',
                  calendars: [
                    BasicCalendarCard(
                      title: '기본 캘린더',
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CalendarSection(
                  title: '선택 가능한 캘린더',
                  calendars: [
                    SelectableCalendarCard(
                      title: '선택 가능한 캘린더',
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateChanged: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CalendarSection(
                  title: '범위 선택 캘린더',
                  calendars: [
                    RangeCalendarCard(
                      title: '범위 선택 캘린더',
                      initialDate: _focusedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onRangeChanged: (start, end) {
                        setState(() {
                          if (start != null) {
                            _focusedDate = start;
                          }
                        });
                      },
                      selectableDayPredicate: (date) {
                        // 주말 선택 불가
                        return date.weekday != DateTime.saturday &&
                            date.weekday != DateTime.sunday;
                      },
                      description: '선택 가능한 날짜: 평일만 선택 가능',
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
