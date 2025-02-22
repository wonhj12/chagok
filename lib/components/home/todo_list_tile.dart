import 'package:chagok/components/home/todo_tag_box.dart';
import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/todo_tag.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  final Todo todo;
  const TodoListTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
    );
  }
}
