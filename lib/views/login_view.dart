import 'dart:io';

import 'package:chagok/components/common/custom_scaffold.dart';
import 'package:chagok/components/login/login_button.dart';
import 'package:chagok/utils/palette.dart';
import 'package:chagok/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = context.watch<LoginViewModel>();

    return CustomScaffold(
      isLoading: loginViewModel.isLoading,
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              width: 256,
              height: 256,
              'assets/icons/sunglass.png',
            ),
          ),

          // 카카오톡 로그인
          LoginButton(
            icon: 'logo_kakao.svg',
            text: '카카오톡으로 시작하기',
            background: Color(0xFFFEE500),
            onTap: loginViewModel.signInWithKakao,
          ),
          const SizedBox(height: 12),

          // 구글 로그인
          LoginButton(
            icon: 'logo_google.svg',
            text: 'Google로 시작하기',
            background: Palette.container,
            onTap: loginViewModel.signInWithGoogle,
          ),
          const SizedBox(height: 12),

          // 애플 로그인
          if (Platform.isIOS)
            LoginButton(
              icon: 'logo_apple.svg',
              text: 'Apple로 시작하기',
              background: Palette.container,
              onTap: loginViewModel.signInWithApple,
            ),

          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
