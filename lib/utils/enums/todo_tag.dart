import 'dart:ui';

import 'package:chagok/utils/palette.dart';

enum TodoTag {
  completed(name: '완료', bgColor: Palette.success, textColor: Palette.container);

  /// 이름
  final String name;

  /// 배경 색
  final Color bgColor;

  /// 텍스트 색
  final Color textColor;

  const TodoTag({
    required this.name,
    required this.bgColor,
    required this.textColor,
  });
}
