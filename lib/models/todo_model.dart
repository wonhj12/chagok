import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class TodoModel with ChangeNotifier {
  /// 현재 선택된 날짜
  DateTime selectedDate = DateTime.now();

  /// 선택된 날짜의 todo 리스트
  List<Todo> todos = [
    Todo(
      title: '테스트 1',
      emotion: Emotion.happy,
      time: TimeOfDay(hour: 9, minute: 0),
      isCompleted: true,
    ),
    Todo(
      title: '테스트 2',
      emotion: Emotion.longing,
      isCompleted: false,
    ),
    Todo(
      title: '테스트 3',
      emotion: Emotion.soso,
      isCompleted: false,
    ),
    Todo(
      title: '테스트 4',
      emotion: Emotion.sad,
      time: TimeOfDay(hour: 13, minute: 30),
      isCompleted: false,
    ),
    Todo(
      title: '테스트 5',
      emotion: Emotion.hate,
      isCompleted: false,
    ),
  ];
}
