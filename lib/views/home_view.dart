import 'package:chagok/components/common/custom_scaffold.dart';
import 'package:chagok/components/home/calendar.dart';
import 'package:chagok/components/home/todo_list.dart';
import 'package:chagok/components/home/week_day_tile.dart';
import 'package:chagok/utils/palette.dart';
import 'package:chagok/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = context.watch<HomeViewModel>();

    return CustomScaffold(
      isLoading: homeViewModel.isLoading,
      topPadding: true,
      onTap: homeViewModel.onTap,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 날짜 기본 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 요일
              GestureDetector(
                key: homeViewModel.weekdayKey,
                onLongPressStart: homeViewModel.onLongPressWeekday,
                child: Text(
                  homeViewModel.getWeekDay(),
                  style: Palette.largeTitleSemibold,
                ),
              ),

              // 날짜
              GestureDetector(
                onTap: homeViewModel.onTapToggleCalendar,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        // 달력 표시 화살표
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns:
                              homeViewModel.showCalendar ? 0.5 : 0.0, // 180도 회전
                          child: const Icon(Icons.arrow_drop_down_rounded),
                        ),

                        // 월, 일
                        Text(homeViewModel.getMonthDay(),
                            style: Palette.headline),
                      ],
                    ),

                    // 년
                    Text(
                      homeViewModel.getYear(),
                      style: Palette.body.copyWith(
                        color: Palette.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 32),

                    // 날짜 선택
                    WeekDayTile(
                      selectedWeek: homeViewModel.todoModel.selectedWeek,
                      isSelectedDay: homeViewModel.isSelectedDay,
                      onTapDateTile: homeViewModel.onTapDateTile,
                    ),
                    const SizedBox(height: 24),

                    // 할 일 목록
                    TodoList(
                      todos: homeViewModel.todoModel.selectedTodos,
                      onTapTodo: homeViewModel.onTapTodo,
                      onPressedDelete: homeViewModel.onPressedDelete,
                      onPressedComplete: homeViewModel.onCompleteTodo,
                    ),
                  ],
                ),

                // 달력
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) => SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1.0,
                    child: child,
                  ),
                  child: homeViewModel.showCalendar
                      ? Calendar(
                          focusedDay: homeViewModel.todoModel.selectedDate,
                          onDaySelected: homeViewModel.onDaySelected,
                          markers: homeViewModel.todoModel.markers,
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Material(
        elevation: 1,
        shape: CircleBorder(),
        shadowColor: Palette.onSurfaceVariant,
        child: IconButton.filled(
          onPressed: homeViewModel.onPressedFAB,
          icon: Icon(
            Icons.add_rounded,
            size: 32,
          ),
        ),
      ),
    );
  }
}
