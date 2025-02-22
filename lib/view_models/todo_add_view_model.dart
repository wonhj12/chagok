import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:chagok/utils/palette.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class TodoAddViewModel with ChangeNotifier {
  TodoModel todoModel;
  BuildContext context;
  TodoAddViewModel({required this.todoModel, required this.context});

  /// 메모 입력 6줄 제한
  TextEditingValue limitLines(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int newLines = newValue.text.split('\n').length;
    if (newLines > 6) {
      return oldValue;
    } else {
      return newValue;
    }
  }

  /// 시간 선택
  void onPressedTime() async {
    Navigator.of(context).push(
      showPicker(
        value: Time.fromTimeOfDay(todoModel.time ?? TimeOfDay.now(), null),
        onChange: (time) {
          todoModel.time = time.toTimeOfDay();
          notifyListeners();
        },
        borderRadius: 20,
        height: 200,
        is24HrFormat: true,
        iosStylePicker: true,
        blurredBackground: true,
        accentColor: Palette.primary,
        unselectedColor: Palette.primary,
        backgroundColor: Palette.surface,
        cancelText: '취소',
        okText: '확인',
        hourLabel: '시',
        minuteLabel: '분',
        okStyle: Palette.callout.copyWith(fontWeight: FontWeight.w600),
        cancelStyle: Palette.callout.copyWith(color: Palette.onSurfaceVariant),
        hmsStyle: Palette.callout.copyWith(color: Palette.onSurfaceVariant),
        sunAsset: Image.asset('assets/icons/sun.png'),
        moonAsset: Image.asset('assets/icons/moon.png'),
      ),
    );
  }

  /// 설정된 시간 표시
  String getTime() {
    return todoModel.time != null
        ? timeOfDayToString(todoModel.time!)
        : '설정 안함';
  }

  /// 주어진 감정과 선택된 감정 일치 여부를 반환
  bool isSelectedEmotion(Emotion emotion) {
    return emotion == todoModel.emotion;
  }

  /// 감정 선택
  void onTapEmotion(Emotion emotion) {
    todoModel.emotion = emotion;
    notifyListeners();
  }
}
