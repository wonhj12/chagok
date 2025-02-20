import 'package:chagok/models/todo.dart';
import 'package:flutter/material.dart';

class TodoModel with ChangeNotifier {
  /// 현재 선택된 날짜
  DateTime selectedDate = DateTime.now();

  /// 선택된 날짜의 todo 리스트
  List<Todo> todo = [];
}
