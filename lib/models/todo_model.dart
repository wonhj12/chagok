import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class TodoModel with ChangeNotifier {
  /// 현재 선택된 날짜
  DateTime selectedDate = DateTime.now();

  List<DateTime> selectedWeek = [];

  /// 선택된 날짜의 todo 리스트
  List<Todo> todos = [
    Todo(
      id: 0,
      title: '테스트 1',
      emotion: Emotion.happy,
      time: TimeOfDay(hour: 9, minute: 0),
      isCompleted: true,
    ),
    Todo(
      id: 1,
      title: '테스트 2',
      emotion: Emotion.longing,
      isCompleted: false,
    ),
    Todo(
      id: 2,
      title: '테스트 3',
      emotion: Emotion.soso,
      isCompleted: false,
    ),
    Todo(
      id: 3,
      title: '테스트 4',
      emotion: Emotion.sad,
      time: TimeOfDay(hour: 13, minute: 30),
      isCompleted: false,
    ),
    Todo(
      id: 4,
      title: '테스트 5',
      emotion: Emotion.hate,
      isCompleted: false,
    ),
  ];

  /* Todo 등록 관련 변수 */
  /// 제목
  TextEditingController title = TextEditingController();

  /// 메모
  TextEditingController memo = TextEditingController();

  /// 시간
  TimeOfDay? time;

  /// 감정
  Emotion emotion = Emotion.happy;

  TodoModel() {
    // 모델이 처음 생성될 때 오늘이 포함된 주차 계산
    getSelectedWeek();
  }

  /// Todo 등록 변수 초기화
  void resetAddTodo() {
    title.clear();
    memo.clear();
    time = null;
    emotion = Emotion.happy;
  }

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
