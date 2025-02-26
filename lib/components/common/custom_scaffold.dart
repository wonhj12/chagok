import 'package:chagok/components/common/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomScaffold extends StatelessWidget {
  /// 상단 제목
  final String? title;

  /// 앱바 뒤로가기 표시 여부
  final bool showBackBtn;

  /// 하단 크기 자동 조절
  final bool? resizeToAvoidBottomInset;

  /// 로딩 중 여부
  final bool isLoading;

  /// 상단 패딩 값
  final bool topPadding;

  /// body 위젯
  final Widget? body;

  /// 하단 floating action button
  final Widget? floatingActionButton;

  /// 네비게이션 바
  final Widget? bottomNavigationBar;

  /// 화면 탭
  final Function()? onTap;

  /// ### Padding, margin 등 공통 설정 값이 적용된 Scaffold
  /// 좌우 padding: 20px
  const CustomScaffold({
    super.key,
    this.title,
    this.showBackBtn = false,
    this.resizeToAvoidBottomInset,
    this.isLoading = false,
    this.topPadding = false,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap?.call();
      },
      child: Scaffold(
        appBar: title != null
            ? AppBar(
                title: Text(title!),
                leading: showBackBtn
                    ? GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Icons.arrow_back_ios_new),
                      )
                    : null,
              )
            : null,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          child: Stack(
            children: [
              // body
              Padding(
                padding: EdgeInsets.fromLTRB(20, topPadding ? 20 : 0, 20, 0),
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
