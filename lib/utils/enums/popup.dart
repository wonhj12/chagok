import 'dart:ui';

import 'package:chagok/utils/palette.dart';

enum Popup {
  delete(
    icon: 'trash',
    text: '이 일정을 삭제할까요?',
    okText: '삭제',
    color: Palette.error,
  ),
  logout(
    icon: 'lock',
    text: '로그아웃 하시겠어요?',
    okText: '로그아웃',
    color: Palette.primary,
  ),
  deleteUser(
    icon: 'lock',
    text: '계정을 삭제하시겠어요?',
    okText: '탈퇴',
    color: Palette.error,
  );

  final String icon;
  final String text;
  final String okText;
  final Color color;
  const Popup({
    required this.icon,
    required this.text,
    required this.okText,
    required this.color,
  });
}
