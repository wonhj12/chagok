import 'package:chagok/components/common/radio_button.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class EmotionBox extends StatelessWidget {
  /// 감정
  final Emotion emotion;

  /// 선택 여부
  final bool isSelected;

  const EmotionBox({
    super.key,
    required this.emotion,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 128,
      child: Column(
        children: [
          // 선택 라디오 버튼
          RadioButton(isSelected: isSelected),
          const SizedBox(height: 16),

          // 아이콘
          Image.asset(
            width: 64,
            height: 64,
            'assets/icons/emotion_${emotion.name}.png',
          ),
          const SizedBox(height: 12),

          Text(emotion.description, style: Palette.caption)
        ],
      ),
    );
  }
}
