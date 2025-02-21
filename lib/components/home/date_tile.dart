import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class DateTile extends StatelessWidget {
  /// 일
  final int day;

  /// 요일
  final String weekDay;

  /// 선택된 날짜 여부
  final bool isSelected;

  const DateTile({
    super.key,
    required this.day,
    required this.weekDay,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 64,
      decoration: BoxDecoration(
        color: isSelected ? Palette.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 일
          Text(
            '$day',
            style: Palette.headline.copyWith(
              color: isSelected ? Palette.surface : Palette.onSurface,
            ),
          ),

          // 요일
          Text(
            weekDay,
            style: Palette.caption.copyWith(
              color: isSelected ? Palette.surface : Palette.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
