import 'package:chagok/components/common/custom_scaffold.dart';
import 'package:chagok/components/home/calendar.dart';
import 'package:chagok/components/home/todo_list.dart';
import 'package:chagok/components/home/week_container.dart';
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 날짜 기본 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 요일
              Text(
                homeViewModel.getWeekDay(),
                style: Palette.largeTitleSemibold,
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
                        Icon(
                          homeViewModel.showCalendar
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
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
                    WeekContainer(
                      selectedWeek: homeViewModel.todoModel.selectedWeek,
                      isSelectedDay: homeViewModel.isSelectedDay,
                      onTapDateTile: homeViewModel.onTapDateTile,
                    ),
                    const SizedBox(height: 24),

                    // 할 일 목록
                    TodoList(
                      todos: homeViewModel.todoModel.todos,
                      onTapTodo: homeViewModel.onTapTodo,
                    ),
                  ],
                ),

                // 달력
                if (homeViewModel.showCalendar)
                  Calendar(
                    focusedDay: homeViewModel.todoModel.selectedDate,
                    onDaySelected: homeViewModel.OnDaySelected,
                  ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: IconButton.filled(
        onPressed: homeViewModel.onPressedFAB,
        icon: Icon(
          Icons.add_rounded,
          size: 32,
        ),
        enableFeedback: true,
      ),
    );
  }
}
