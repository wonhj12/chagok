import 'package:chagok/components/home/todo_list_tile.dart';
import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/palette.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onTapTodo;
  const TodoList({super.key, required this.todos, required this.onTapTodo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Palette.container,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (_, index) => TodoListTile(
            todo: todos[index],
            onTapTodo: () => onTapTodo(todos[index]),
          ),
          separatorBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DottedLine(
              dashColor: Palette.onSurfaceVariant,
              dashLength: 2,
              dashGapLength: 5,
            ),
          ),
          itemCount: todos.length,
        ),
      ),
    );
  }
}
