import 'package:chagok/components/common/custom_ink_well.dart';
import 'package:chagok/components/home/todo_tag_box.dart';
import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/todo_tag.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListTile extends StatelessWidget {
  final Todo todo;
  final Function() onTapTodo;
  final void Function() onDismissed;
  final void Function() onPressedComplete;
  const TodoListTile({
    super.key,
    required this.todo,
    required this.onTapTodo,
    required this.onDismissed,
    required this.onPressedComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todo),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(
          onDismissed: onDismissed,
          closeOnCancel: true,
        ),
        motion: const DrawerMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (_) => onPressedComplete(),
            backgroundColor: Palette.success,
            foregroundColor: Palette.surface,
            icon: todo.isCompleted
                ? Icons.cancel_outlined
                : Icons.check_circle_outline_rounded,
          ),
          SlidableAction(
            onPressed: (_) => onDismissed(),
            backgroundColor: Palette.error,
            foregroundColor: Palette.surface,
            icon: Icons.delete_rounded,
          ),
        ],
      ),
      child: CustomInkWell(
        onTap: onTapTodo,
        backgroundColor: Palette.container,
        child: Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 감정 아이콘
              Image.asset(
                width: 20,
                height: 20,
                'assets/icons/emotion_${todo.emotion.name}.png',
              ),
              const SizedBox(width: 20),

              // 제목
              Text(todo.title, style: Palette.body),
              const SizedBox(width: 12),

              // 완료 표시
              AnimatedScale(
                scale: todo.isCompleted ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300), // 애니메이션 시간 조정
                curve: Curves.easeInOut, // 애니메이션 곡선
                child: TodoTagBox(tag: TodoTag.completed),
              ),
              const Spacer(),

              // 시간
              Text(
                todo.time != null ? timeOfDayToString(todo.time!) : '',
                style: Palette.caption.copyWith(
                  color: Palette.onSurfaceVariant,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
