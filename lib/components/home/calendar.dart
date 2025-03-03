import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  /// 초기 선택 날짜
  final DateTime focusedDay;

  /// 날짜 선택
  final Function(DateTime) onDaySelected;

  /// 일정이 존재하는 날짜 마커
  final Set<DateTime>? markers;

  const Calendar({
    super.key,
    required this.focusedDay,
    required this.onDaySelected,
    this.markers,
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
          defaultBuilder: (_, day, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 마커
              SizedBox(
                height: 12,
                child:
                    (markers != null && markers!.any((d) => isSameDay(d, day)))
                        ? Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Palette.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        : SizedBox.shrink(),
              ),

              // 날짜
              Text('${day.day}', style: Palette.callout),
              SizedBox(height: 12),
            ],
          ),
          todayBuilder: (_, day, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 마커
              SizedBox(
                height: 12,
                child:
                    (markers != null && markers!.any((d) => isSameDay(d, day)))
                        ? Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Palette.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        : SizedBox.shrink(),
              ),

              // 날짜
              Text(
                '${day.day}',
                style: Palette.callout.copyWith(
                  color: Palette.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
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
