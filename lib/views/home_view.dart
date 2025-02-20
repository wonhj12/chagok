import 'package:chagok/components/common/custom_scaffold.dart';
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
          Text('금요일', style: Palette.largeTitleSemibold),
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
