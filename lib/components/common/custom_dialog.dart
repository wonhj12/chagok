import 'package:chagok/utils/enums/popup.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

Future<void> customDialog({
  required BuildContext context,
  required Popup type,
  required Function() onPressed,
}) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),

            // 아이콘
            Image.asset('assets/icons/${type.icon}.png', width: 64, height: 64),
            const SizedBox(height: 20),

            // 문구
            Text(type.text, style: Palette.headline),
            const SizedBox(height: 24),

            // 취소, 확인
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 취소
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text(
                    '취소',
                    style: Palette.callout.copyWith(
                      color: Palette.onSurfaceVariant,
                    ),
                  ),
                ),

                // 삭제
                TextButton(
                  onPressed: () {
                    onPressed();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    type.okText,
                    style: Palette.callout.copyWith(
                      fontWeight: FontWeight.w600,
                      color: type.color,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
