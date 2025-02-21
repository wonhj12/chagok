import 'package:chagok/components/common/custom_scaffold.dart';
import 'package:chagok/components/home/emotion_box.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:chagok/utils/palette.dart';
import 'package:chagok/view_models/todo_add_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoAddView extends StatelessWidget {
  const TodoAddView({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoAddViewModel todoAddViewModel = context.watch<TodoAddViewModel>();

    return CustomScaffold(
      title: '등록하기',
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Palette.container,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: TextFormField(
                  style: Palette.title,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                    hintText: '제목',
                    hintStyle: Palette.title.copyWith(
                      color: Palette.onSurfaceVariant,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 메모
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Palette.container,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                style: Palette.body,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                  hintText: '메모',
                  hintStyle: Palette.body.copyWith(
                    color: Palette.onSurfaceVariant,
                  ),
                ),
                maxLines: 6,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 24),

            // 시간
            Container(
              width: double.infinity,
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Palette.container,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '시간',
                    style: Palette.body.copyWith(
                      color: todoAddViewModel.todoModel.time == null
                          ? Palette.onSurfaceVariant
                          : Palette.onSurface,
                    ),
                  ),

                  // 시간 선택 컨테이너
                  SizedBox(
                    width: 100,
                    height: 36,
                    child: FilledButton(
                      onPressed: todoAddViewModel.onPressedTime,
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: todoAddViewModel.todoModel.time == null
                            ? Palette.onSurfaceVariant
                            : Palette.onSurface,
                        backgroundColor: Palette.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        todoAddViewModel.getTime(),
                        style: Palette.callout,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 감정
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('감정', style: Palette.headline),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '어떤 일인가요? 이 일을 할 때 드는 감정을 선택해 주세요.',
                style: Palette.caption,
              ),
            ),
            const SizedBox(height: 24),

            // 감정 선택
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EmotionBox(
                  emotion: Emotion.happy,
                  isSelected: todoAddViewModel.isSelectedEmotion(Emotion.happy),
                  onTap: () => todoAddViewModel.onTapEmotion(Emotion.happy),
                ),
                EmotionBox(
                  emotion: Emotion.longing,
                  isSelected:
                      todoAddViewModel.isSelectedEmotion(Emotion.longing),
                  onTap: () => todoAddViewModel.onTapEmotion(Emotion.longing),
                ),
                EmotionBox(
                  emotion: Emotion.soso,
                  isSelected: todoAddViewModel.isSelectedEmotion(Emotion.soso),
                  onTap: () => todoAddViewModel.onTapEmotion(Emotion.soso),
                ),
                EmotionBox(
                  emotion: Emotion.hate,
                  isSelected: todoAddViewModel.isSelectedEmotion(Emotion.hate),
                  onTap: () => todoAddViewModel.onTapEmotion(Emotion.hate),
                ),
                EmotionBox(
                  emotion: Emotion.sad,
                  isSelected: todoAddViewModel.isSelectedEmotion(Emotion.sad),
                  onTap: () => todoAddViewModel.onTapEmotion(Emotion.sad),
                ),
              ],
            ),
            const Spacer(),

            // 등록 버튼
            SizedBox(
              width: double.infinity,
              height: 60,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('등록하기', style: Palette.headline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
