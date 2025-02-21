import 'package:chagok/models/todo_model.dart';
import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class TodoAddViewModel with ChangeNotifier {
  TodoModel todoModel;
  BuildContext context;
  TodoAddViewModel({required this.todoModel, required this.context});

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
