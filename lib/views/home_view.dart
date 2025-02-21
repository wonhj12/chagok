import 'package:chagok/components/common/custom_scaffold.dart';
import 'package:chagok/components/home/date_tile.dart';
import 'package:chagok/components/home/todo_list_tile.dart';
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
      body: Column(
        children: [
          // 날짜 기본 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 요일
              Text('금요일', style: Palette.largeTitleSemibold),

              // 날짜
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('2월 21일', style: Palette.headline),
                  Text(
                    '2025',
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
              DateTile(day: 16, weekDay: '일', isSelected: false),
              DateTile(day: 17, weekDay: '월', isSelected: false),
              DateTile(day: 18, weekDay: '화', isSelected: false),
              DateTile(day: 19, weekDay: '수', isSelected: false),
              DateTile(day: 20, weekDay: '목', isSelected: false),
              DateTile(day: 21, weekDay: '금', isSelected: true),
              DateTile(day: 22, weekDay: '토', isSelected: false),
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
                separatorBuilder: (_, __) => Divider(
                  height: 0,
                  thickness: 0.5,
                  color: Palette.onSurfaceVariant,
                ),
                itemCount: homeViewModel.todoModel.todos.length,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: IconButton.filled(
        onPressed: () {},
        icon: Icon(
          Icons.add_rounded,
          size: 32,
        ),
      ),
    );
  }
}
