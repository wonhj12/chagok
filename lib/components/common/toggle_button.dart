import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool isEnabled;
  final Function() onTap;
  const ToggleButton({
    super.key,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 28,
        decoration: BoxDecoration(
          color: Palette.surface,
          border: Border.all(
            color: isEnabled ? Palette.primary : Palette.onSurfaceVariant,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isEnabled ? Palette.primary : Palette.onSurfaceVariant,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
