import 'package:chagok/components/common/loading_screen.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  /// 하단 크기 자동 조절
  final bool? resizeToAvoidBottomInset;

  /// 로딩 중 여부
  final bool isLoading;

  /// body 위젯
  final Widget? body;

  /// 하단 floating action button
  final Widget? floatingActionButton;

  /// 네비게이션 바
  final Widget? bottomNavigationBar;

  /// ### Padding, margin 등 공통 설정 값이 적용된 Scaffold
  /// 좌우 padding: 20px
  const CustomScaffold({
    super.key,
    this.resizeToAvoidBottomInset,
    this.isLoading = false,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          child: Stack(
            children: [
              // body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: body,
              ),

              // 로딩
              if (isLoading) const Center(child: LoadingScreen())
            ],
          ),
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
