import 'package:chagok/utils/enums/todo_tag.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';

class TodoTagBox extends StatelessWidget {
  final TodoTag tag;
  const TodoTagBox({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 20,
      decoration: BoxDecoration(
        color: tag.bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          tag.name,
          style: Palette.caption.copyWith(color: tag.textColor),
        ),
      ),
    );
  }
}
