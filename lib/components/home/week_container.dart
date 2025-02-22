import 'package:chagok/components/home/date_tile.dart';
import 'package:flutter/material.dart';

class WeekContainer extends StatelessWidget {
  /// 선택된 날짜가 포함된 주
  final List<DateTime> selectedWeek;

  /// 주어진 요일과 선택된 날짜의 일치 여부
  final bool Function(int) isSelectedDay;

  /// 날짜 선택시 선택된 날짜를 변경
  final void Function(int) onTapDateTile;

  const WeekContainer({
    super.key,
    required this.selectedWeek,
    required this.isSelectedDay,
    required this.onTapDateTile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        7,
        (index) => DateTile(
          date: selectedWeek[index],
          isSelected: isSelectedDay(index),
          onTap: () => onTapDateTile(index),
        ),
      ),
    );
  }
}
