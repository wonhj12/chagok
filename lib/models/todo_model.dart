import 'package:chagok/models/todo.dart';
import 'package:chagok/utils/api.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class TodoModel with ChangeNotifier {
  /// 현재 선택된 날짜
  DateTime selectedDate = DateTime.now();

  /// 선택된 주
  List<DateTime> selectedWeek = [];

  /// 선택된 주의 모든 일정 리스트
  List<List<Todo>> todos = [[], [], [], [], [], [], []];

  /// 선택된 월의 일정 마커
  Set<DateTime> markers = {};

  /// TodoList PageController
  late PageController todoListController;

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

  TodoModel();

  /// 모델 초기화
  void reset() {
    selectedDate = DateTime.now();
    selectedWeek = [];
    markers.clear();
    resetTodos();
    resetAddTodo();
  }

  /// 서버에서 받아온 일정 초기화
  void resetTodos() {
    todos = [[], [], [], [], [], [], []];
  }

  /// 일정 등록 변수 초기화
  void resetAddTodo() {
    selectedTodo = null;
    title.clear();
    memo.clear();
    time = null;
    emotion = Emotion.happy;
  }

  /// 모델 init
  Future<void> init() async {
    debugPrint('Init TodoModel');
    reset();
    getSelectedWeek();
    await getMarkers(selectedDate);
    await getTodos();
    todoListController =
        PageController(initialPage: selectedWeekday(), viewportFraction: 1.1);
  }

  /// 선택된 날짜의 요일 계산
  int selectedWeekday() => selectedDate.weekday % 7;

  /// 리스트에 새로운 일정 추가하기
  void addTodo(Todo todo) {
    // todo 리스트에 추가
    todos[selectedWeekday()].add(todo);

    // 마커 추가
    markers.add(DateTime(todo.date.year, todo.date.month, todo.date.day));

    // 정렬
    sortTodo(todos[selectedWeekday()]);
  }

  /// 리스트 정렬
  void sortTodo(List<Todo> list) {
    // 정렬: time을 기준으로 오름차순, time이 같으면 date(추가 순서)를 기준으로 오름차순
    list.sort((a, b) {
      if (a.time == null && b.time != null) return 1; // null 값은 뒤로
      if (a.time != null && b.time == null) return -1;
      if (a.time != null && b.time != null) {
        int timeCompare = a.time!.hour.compareTo(b.time!.hour);
        if (timeCompare == 0) {
          timeCompare = a.time!.minute.compareTo(b.time!.minute);
        }
        if (timeCompare != 0) return timeCompare;
      }
      return a.date.compareTo(b.date);
    });
  }

  /// 리스트에서 일정 제거
  Future<void> removeTodo(int index) async {
    final bool response =
        await API().deleteTodo(todos[selectedWeekday()][index].id);

    // selectedTodos에서 지우면 todos에도 지워짐
    if (response) {
      final Todo removed = todos[selectedWeekday()].removeAt(index);

      // 더이상 todo가 없으면 마커 삭제
      if (todos[selectedWeekday()].isEmpty)
        markers.remove(
            DateTime(removed.date.year, removed.date.month, removed.date.day));
    }
  }

  /// 서버에서 일정 가져오기
  Future<void> getTodos() async {
    resetTodos();
    todos = await API().getTodos(selectedDate);
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
    DateTime sunday = selectedDate.subtract(Duration(days: selectedWeekday()));

    // 일요일부터 토요일까지의 날짜 리스트 생성
    selectedWeek =
        List.generate(7, (index) => sunday.add(Duration(days: index)));
  }

  /// 선택된 날짜가 포함된 월의 마커를 반환
  Future<void> getMarkers(DateTime date) async {
    markers = await API().getMarkers(date);
  }
}
