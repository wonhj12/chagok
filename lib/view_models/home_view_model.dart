import 'package:chagok/models/todo.dart';
import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/api.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/app_route.dart';
import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  final GlobalKey weekdayKey = GlobalKey();

  /// 초기화
  void initialize() async {
    // 일정 불러오기
    await todoModel.getTodos();
    notifyListeners();
  }

  /// 화면 탭 로직
  void onTap() {
    if (showCalendar) {
      showCalendar = false;
      notifyListeners();
    }
  }

  /// 선택된 날짜의 요일 반환
  String getWeekDay() => weekdayToString(todoModel.selectedDate.weekday);

  /// 선택된 날짜의 월, 일을 반환
  String getMonthDay() {
    return '${todoModel.selectedDate.month}월 ${todoModel.selectedDate.day}일';
  }

  /// 선택된 날짜의 연도를 반환
  String getYear() => '${todoModel.selectedDate.year}';

  /// 요일 longPress시 메뉴 표시
  void onLongPressWeekday(LongPressStartDetails details) {
    HapticFeedback.lightImpact();

    // 요일 텍스트 RenderBox
    final RenderBox? renderBox =
        weekdayKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    // 텍스트 위젯의 전역 좌표와 크기
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // 텍스트의 하단 위치 계산
    // 텍스트 위젯의 좌측 하단 좌표
    final Offset menuPosition = Offset(offset.dx, offset.dy + size.height);

    // 화면 크기 계산
    final screenSize = MediaQuery.of(context).size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        menuPosition.dx,
        menuPosition.dy + 4,
        screenSize.width - menuPosition.dx,
        screenSize.height - menuPosition.dy,
      ),
      menuPadding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        PopupMenuItem(
          onTap: logout,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('로그아웃', style: Palette.callout),
        ),
        PopupMenuItem(
          onTap: deleteUser,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('회원 탈퇴', style: Palette.callout),
        ),
      ],
    );
  }

  /// 로그아웃
  void logout() async {
    final SupabaseClient supabase = Supabase.instance.client;

    isLoading = true;
    notifyListeners();

    await supabase.auth.signOut();

    isLoading = false;
    notifyListeners();

    context.goNamed(AppRoute.login.name);
  }

  /// 회원 탈퇴
  void deleteUser() async {
    final SupabaseClient supabase = Supabase.instance.client;

    isLoading = true;
    notifyListeners();

    // 회원 삭제
    await supabase.functions.invoke('delete-user', headers: {
      'Authorization': 'Bearer ${supabase.auth.currentSession?.accessToken}'
    });
    debugPrint('Deleted user');

    await supabase.auth.signOut();

    isLoading = false;
    notifyListeners();

    context.goNamed(AppRoute.login.name);
  }

  /// 달력 표시 여부 변경
  void onTapToggleCalendar() {
    HapticFeedback.lightImpact();
    showCalendar = !showCalendar;
    notifyListeners();
  }

  /// 달력에서 날짜 선택
  void OnDaySelected(DateTime selectedDay) async {
    // 선택된 날짜 업데이터
    todoModel.selectedDate = selectedDay;

    // 선택된 날짜가 포함된 주 업데이트
    todoModel.getSelectedWeek();

    // 달력 닫기
    showCalendar = false;

    // 일정 불러오기 위한 isLoading 활성화
    isLoading = true;
    notifyListeners();

    // 일정 서버에서 가져오기
    // 달력을 닫은 후 일정 불러오기 진행
    await todoModel.getTodos();

    isLoading = false;
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
  void onTapTodo(Todo todo) async {
    // Todo 선택
    todoModel.selectTodo(todo);
    await context.pushNamed(AppRoute.add.name);
    notifyListeners();
  }

  /// Todo 우 -> 좌 스와이프 (삭제)
  void onDismissedTodo(int index) async {
    // 일정 제거
    await todoModel.removeTodo(index);
    notifyListeners();
  }

  /// Todo 좌 -> 우 스와이프 (완료)
  void onCompleteTodo(int index) async {
    // 업데이트할 일정 선택
    final Todo todo = todoModel.selectedTodos[index];

    // 완료, 미완료 상태 변경
    final bool response = await API().patchTodo(
      todo.id,
      {'isCompleted': !todo.isCompleted},
    );

    // db에 반영이 됐으면 TodoModel에도 반영
    if (response) {
      todo.updateTodo(isCompleted: !todo.isCompleted);
    }

    notifyListeners();
  }

  /// FAB 클릭시 Todo 추가 페이지 이동
  void onPressedFAB() async {
    HapticFeedback.lightImpact();

    todoModel.resetAddTodo();
    await context.pushNamed(AppRoute.add.name);
    notifyListeners();
  }
}
