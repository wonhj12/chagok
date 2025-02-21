import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  /// 선택 여부
  final bool isSelected;
  const RadioButton({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Palette.surface,
        border: Border.all(
          color: isSelected ? Palette.primary : Palette.onSurfaceVariant,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isSelected ? Palette.primary : Palette.surface,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
