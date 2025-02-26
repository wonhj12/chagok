import 'package:chagok/components/common/radio_button.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmotionBox extends StatelessWidget {
  /// 감정
  final Emotion emotion;

  /// 선택 여부
  final bool isSelected;

  /// 선택 함수
  final void Function() onTap;

  const EmotionBox({
    super.key,
    required this.emotion,
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
      child: SizedBox(
        width: 64,
        height: 128,
        child: Column(
          children: [
            // 선택 라디오 버튼
            RadioButton(isSelected: isSelected),
            const SizedBox(height: 16),

            // 아이콘
            // 크기 변경 애니메이션 적용
            AnimatedScale(
              scale: isSelected ? 1.2 : 1.0, // 선택 시 확대
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: Image.asset(
                width: 64,
                height: 64,
                'assets/icons/emotion_${emotion.name}.png',
              ),
            ),
            const SizedBox(height: 12),

            Text(emotion.description, style: Palette.caption)
          ],
        ),
      ),
    );
  }
}
