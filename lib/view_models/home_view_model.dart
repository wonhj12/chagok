import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel with ChangeNotifier {
  final TodoModel todoModel;
  final BuildContext context;
  HomeViewModel({required this.todoModel, required this.context});

  /// 선택된 날짜의 요일 반환
  String getWeekDay() => weekdayToString(todoModel.selectedDate.weekday);

  /// 선택된 날짜의 월, 일을 반환
  String getMonthDay() {
    return '${todoModel.selectedDate.month}월 ${todoModel.selectedDate.day}일';
  }

  /// 선택된 날짜의 연도를 반환
  String getYear() => '${todoModel.selectedDate.year}';

  /// 주어진 요일이 선택된 날짜가 일치 여부를 반환
  bool isSelectedDay(int index) {
    return index == todoModel.selectedDate.weekday % 7;
  }

  /// 날짜 선택시 선택 날짜를 변경
  void onTapDateTile(int index) {
    todoModel.selectedDate = todoModel.selectedWeek[index];
    notifyListeners();
  }

  /// FAB 클릭시 Todo 추가 페이지 이동
  void onPressedFAB() {
    context.goNamed(AppRoute.add.name);
  }
}
