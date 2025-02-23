import 'package:chagok/models/todo.dart';
import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/api.dart';
import 'package:chagok/utils/date_time.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:chagok/utils/palette.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoAddViewModel with ChangeNotifier {
  TodoModel todoModel;
  BuildContext context;
  TodoAddViewModel({required this.todoModel, required this.context});

  /// 페이지 로딩 상태
  bool isLoading = false;

  /// AppBar 타이틀 텍스트
  String titleText() => todoModel.selectedTodo == null ? '새 일정 등록' : '일정 확인';

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

  /// 텍스트 수정
  void onChangedText() {
    notifyListeners();
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

  /// 등록 버튼 텍스트
  String addBtnText() {
    return todoModel.selectedTodo == null
        ? '등록하기'
        : todoModel.isTodoChanged()
            ? '수정하기'
            : '완료하기';
  }

  /// 일정 등록
  void onPressedAddBtn() async {
    isLoading = true;
    notifyListeners();

    if (todoModel.selectedTodo == null) {
      // 새 일정 등록
      // db에 새 일정 등록
      final Todo todo = await API().postTodo({
        'title': todoModel.title.text.trim(),
        'memo': todoModel.memo.text.trim(),
        'date': todoModel.selectedDate.millisecondsSinceEpoch,
        'time': todoModel.time != null
            ? '${todoModel.time!.hour}:${todoModel.time!.minute}:00'
            : null,
        'emotion': todoModel.emotion.name,
        'isCompleted': false,
      });

      // 모델에 등록한 일정 추가
      todoModel.addTodo(todo);
    } else if (todoModel.isTodoChanged()) {
      // 일정 수정

      // db 업데이트
      final bool response = await API().patchTodo(
        todoModel.selectedTodo!.id,
        {
          'title': todoModel.title.text.trim(),
          'memo': todoModel.memo.text.trim(),
          'time': todoModel.time != null
              ? '${todoModel.time!.hour}:${todoModel.time!.minute}:00'
              : null,
          'emotion': todoModel.emotion.name,
        },
      );

      // db에 반영이 됐으면 TodoModel에도 반영
      if (response) {
        todoModel.selectedTodo!.updateTodo(
          title: todoModel.title.text.trim(),
          memo: todoModel.memo.text.trim(),
          time: todoModel.time,
          emotion: todoModel.emotion,
        );
      }
    }

    isLoading = false;
    notifyListeners();

    context.pop();
  }
}
