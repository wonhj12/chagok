import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeekDayTile extends StatelessWidget {
  /// 넓이
  final double width;

  /// 날짜
  final DateTime date;

  /// 선택된 날짜 일정 포함 여부
  final bool hastodo;

  /// 선택된 날짜 여부
  final bool isSelected;

  /// 날짜 선택
  final void Function() onTap;

  const WeekDayTile({
    super.key,
    required this.width,
    required this.date,
    required this.hastodo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        height: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 일정 존재 표시
            SizedBox(
              height: 8,
              child: hastodo
                  ? Container(
                      width: 4,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Palette.surface : Palette.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : SizedBox.shrink(),
            ),

            // 일
            Text(
              '${date.day}',
              style: Palette.headline.copyWith(
                color: isSelected ? Palette.surface : Palette.onSurface,
              ),
            ),
            const SizedBox(height: 4),

            // 요일
            Text(
              weekdayToString(date.weekday).substring(0, 1),
              style: Palette.caption.copyWith(
                color: isSelected ? Palette.surface : Palette.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
