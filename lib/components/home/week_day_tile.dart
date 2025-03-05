import 'package:chagok/components/home/date_tile.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class WeekDayTile extends StatelessWidget {
  /// 선택된 날짜가 포함된 주
  final List<DateTime> selectedWeek;

  /// 주어진 요일과 선택된 날짜의 일치 여부
  final bool Function(int) isSelectedDay;

  /// 날짜 선택시 선택된 날짜를 변경
  final void Function(int) onTapDateTile;

  const WeekDayTile({
    super.key,
    required this.selectedWeek,
    required this.isSelectedDay,
    required this.onTapDateTile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // 타일 넓이
      final double tileWidth = 48;

      // 선택된 요일 계산
      final int selectedIndex =
          selectedWeek.indexWhere((date) => isSelectedDay(date.weekday % 7));

      // 위치 계산
      final double spacing = (constraints.maxWidth - (tileWidth * 7)) / 6;

      return Stack(
        children: [
          // 배경 (전환 애니메이션 적용)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: selectedIndex * (tileWidth + spacing),
            child: Container(
              width: tileWidth,
              height: 64,
              decoration: BoxDecoration(
                color: Palette.primary,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // 날짜
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => DateTile(
                date: selectedWeek[index],
                isSelected: isSelectedDay(index),
                onTap: () => onTapDateTile(index),
              ),
            ),
          ),
        ],
      );
    });
  }
}
