import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateTile extends StatelessWidget {
  /// 날짜
  final DateTime date;

  /// 선택된 날짜 여부
  final bool isSelected;

  /// 날짜 선택
  final void Function() onTap;

  const DateTile({
    super.key,
    required this.date,
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
        width: 48,
        height: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
