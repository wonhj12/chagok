import 'package:chagok/components/common/custom_scaffold.dart';
import 'package:chagok/components/home/date_tile.dart';
import 'package:chagok/components/home/todo_list_tile.dart';
import 'package:chagok/utils/palette.dart';
import 'package:chagok/view_models/home_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = context.watch<HomeViewModel>();

    return CustomScaffold(
      body: Column(
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 월, 일
                  Text(homeViewModel.getMonthDay(), style: Palette.headline),

                  // 년
                  Text(
                    homeViewModel.getYear(),
                    style: Palette.body.copyWith(
                      color: Palette.onSurfaceVariant,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),

          // 날짜 선택
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[0],
                isSelected: homeViewModel.isSelectedDay(0),
                onTap: () => homeViewModel.onTapDateTile(0),
              ),
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[1],
                isSelected: homeViewModel.isSelectedDay(1),
                onTap: () => homeViewModel.onTapDateTile(1),
              ),
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[2],
                isSelected: homeViewModel.isSelectedDay(2),
                onTap: () => homeViewModel.onTapDateTile(2),
              ),
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[3],
                isSelected: homeViewModel.isSelectedDay(3),
                onTap: () => homeViewModel.onTapDateTile(3),
              ),
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[4],
                isSelected: homeViewModel.isSelectedDay(4),
                onTap: () => homeViewModel.onTapDateTile(4),
              ),
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[5],
                isSelected: homeViewModel.isSelectedDay(5),
                onTap: () => homeViewModel.onTapDateTile(5),
              ),
              DateTile(
                date: homeViewModel.todoModel.selectedWeek[6],
                isSelected: homeViewModel.isSelectedDay(6),
                onTap: () => homeViewModel.onTapDateTile(6),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 할 일 목록
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Palette.container,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (_, index) => TodoListTile(
                  todo: homeViewModel.todoModel.todos[index],
                ),
                separatorBuilder: (_, __) => DottedLine(
                  dashColor: Palette.onSurfaceVariant,
                  dashLength: 2,
                  dashGapLength: 5,
                ),
                itemCount: homeViewModel.todoModel.todos.length,
              ),
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
      ),
    );
  }
}
