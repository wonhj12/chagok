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
  const TodoListTile({
    super.key,
    required this.todo,
    required this.onTapTodo,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todo),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: Palette.success,
            foregroundColor: Palette.surface,
            label: '완료',
          )
        ],
      ),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(
          onDismissed: onDismissed,
          closeOnCancel: true,
        ),
        motion: const BehindMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) => onDismissed(),
            backgroundColor: Palette.error,
            foregroundColor: Palette.surface,
            label: '삭제',
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTapTodo,
          child: Container(
            width: double.infinity,
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Palette.container,
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
                if (todo.isCompleted) TodoTagBox(tag: TodoTag.completed),
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
      ),
    );
  }
}
