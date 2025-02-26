import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  /// 초기 선택 날짜
  final DateTime focusedDay;

  final Function(DateTime) onDaySelected;

  const Calendar({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 432,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: TableCalendar(
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(focusedDay, day),
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        shouldFillViewport: true,
        onDaySelected: (selectedDay, _) {
          HapticFeedback.lightImpact();
          onDaySelected(selectedDay);
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextFormatter: (date, _) => '${date.year}년 ${date.month}월',
          titleTextStyle: Palette.headline,
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          leftChevronIcon: Icon(
            Icons.chevron_left_rounded,
            color: Palette.onSurface,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right_rounded,
            color: Palette.onSurface,
          ),
        ),
        daysOfWeekHeight: 36,
        rowHeight: 52,
        calendarStyle: CalendarStyle(
          defaultTextStyle: Palette.callout,
          weekendTextStyle: Palette.callout,
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          todayTextStyle: Palette.callout.copyWith(
            color: Palette.primary,
            fontWeight: FontWeight.w600,
          ),
          outsideTextStyle: Palette.callout.copyWith(
            color: Palette.onSurfaceVariant,
          ),
          selectedDecoration: const BoxDecoration(
            color: Palette.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: Palette.callout.copyWith(
            color: Palette.surface,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (_, day) => Center(
            child: Text(
              ['월', '화', '수', '목', '금', '토', '일'][day.weekday - 1],
              style: Palette.callout,
            ),
          ),
        ),
      ),
    );
  }
}
