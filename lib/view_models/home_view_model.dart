import 'package:chagok/models/todo.dart';
import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel with ChangeNotifier {
  final TodoModel todoModel;
  final BuildContext context;
  HomeViewModel({required this.todoModel, required this.context}) {
    initialize();
  }

  /// 페이지 로딩 상태
  bool isLoading = false;

  /// 달력 표시 상태
  bool showCalendar = false;

  /// 초기화
  void initialize() async {
    // 일정 불러오기
    await todoModel.getTodos();
    notifyListeners();
  }

  /// 선택된 날짜의 요일 반환
  String getWeekDay() => weekdayToString(todoModel.selectedDate.weekday);

  /// 선택된 날짜의 월, 일을 반환
  String getMonthDay() {
    return '${todoModel.selectedDate.month}월 ${todoModel.selectedDate.day}일';
  }

  /// 선택된 날짜의 연도를 반환
  String getYear() => '${todoModel.selectedDate.year}';

  /// 달력 표시 여부 변경
  void onTapToggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  /// 달력에서 날짜 선택
  void OnDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    // 선택된 날짜 업데이터
    todoModel.selectedDate = selectedDay;

    // 선택된 날짜가 포함된 주 업데이트
    todoModel.getSelectedWeek();

    // 달력 닫기
    showCalendar = false;
    notifyListeners();

    // 일정 서버에서 가져오기
    // 달력을 닫은 후 일정 불러오기 진행
    await todoModel.getTodos();
    notifyListeners();
  }

  /// 주어진 요일과 선택된 날짜 일치 여부를 반환
  bool isSelectedDay(int index) {
    return index == todoModel.selectedDate.weekday % 7;
  }

  /// 날짜 선택시 선택 날짜를 변경
  void onTapDateTile(int index) {
    // 날짜 변경
    todoModel.selectedDate = todoModel.selectedWeek[index];

    // 일정 변경
    todoModel.selectedTodos = todoModel.todos[index];
    notifyListeners();
  }

  /// Todo 선택
  void onTapTodo(Todo todo) {
    // Todo 선택
    todoModel.selectTodo(todo);
    context.goNamed(AppRoute.add.name);
  }

  /// FAB 클릭시 Todo 추가 페이지 이동
  void onPressedFAB() {
    todoModel.resetAddTodo();
    context.goNamed(AppRoute.add.name);
  }
}
