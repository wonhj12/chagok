import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class TodoModel with ChangeNotifier {
  /// 현재 선택된 날짜
  DateTime selectedDate = DateTime.now();

  List<DateTime> selectedWeek = [];

  /// 선택된 날짜의 Todo 리스트
  List<Todo> todos = [];

  /* 일정 등록 관련 변수 */
  /// 제목
  TextEditingController title = TextEditingController();

  /// 메모
  TextEditingController memo = TextEditingController();

  /// 시간
  TimeOfDay? time;

  /// 감정
  Emotion emotion = Emotion.happy;

  /// 선택된 Todo 오브젝트
  Todo? selectedTodo;

  TodoModel() {
    // 모델이 처음 생성될 때 오늘이 포함된 주차 계산
    getSelectedWeek();
  }

  /// 일정 등록 변수 초기화
  void resetAddTodo() {
    selectedTodo = null;
    title.clear();
    memo.clear();
    time = null;
    emotion = Emotion.happy;
  }

  /// 일정 수정시 변수를 선택된 Todo로 동기화
  void selectTodo(Todo todo) {
    selectedTodo = todo;
    title.text = todo.title;
    memo.text = todo.memo ?? '';
    time = todo.time;
    emotion = todo.emotion;
  }

  /// 선택된 일정 수정 여부
  bool isTodoChanged() =>
      selectedTodo?.title != title.text.trim() ||
      (selectedTodo?.memo ?? '') != memo.text.trim() ||
      selectedTodo?.time != time ||
      selectedTodo?.emotion != emotion;

  /// 선택된 날짜가 포함된 주의 날짜를 반환
  void getSelectedWeek() {
    // 선택한 날짜가 포함된 주의 월요일을 계산
    DateTime sunday =
        selectedDate.subtract(Duration(days: selectedDate.weekday));

    // 일요일부터 토요일까지의 날짜 리스트 생성
    selectedWeek =
        List.generate(7, (index) => sunday.add(Duration(days: index)));
  }
}
