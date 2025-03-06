import 'package:chagok/components/home/todo_list_tile.dart';
import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/palette.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  final PageController controller;
  final List<List<Todo>> todos;
  final Function(Todo) onTapTodo;
  final void Function(int) onPressedDelete;
  final void Function(int) onPressedComplete;
  final void Function(int) onPageChanged;
  const TodoList({
    super.key,
    required this.controller,
    required this.todos,
    required this.onTapTodo,
    required this.onPressedDelete,
    required this.onPressedComplete,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: Expanded(
        child: PageView.builder(
          controller: controller,
          itemCount: 7,
          onPageChanged: onPageChanged,
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          itemBuilder: (_, pageIndex) {
            return FractionallySizedBox(
              widthFactor: 1 / controller.viewportFraction,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Palette.container,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: todos[pageIndex].isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (_, index) => TodoListTile(
                          todo: todos[pageIndex][index],
                          onTapTodo: () => onTapTodo(todos[pageIndex][index]),
                          onPressedDelete: () => onPressedDelete(index),
                          onPressedComplete: () => onPressedComplete(index),
                        ),
                        separatorBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DottedLine(
                            dashColor: Palette.onSurfaceVariant,
                            dashLength: 2,
                            dashGapLength: 5,
                          ),
                        ),
                        itemCount: todos[pageIndex].length,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 이미지
                            Image.asset(
                              'assets/icons/sunglass.png',
                              width: 128,
                              height: 128,
                            ),
                            const SizedBox(height: 24),

                            // 일정 없음 문구
                            Text(
                              '일정이 없네요!\n새 일정을 추가해 보세요.',
                              style: Palette.body,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
