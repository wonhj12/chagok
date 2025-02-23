import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class Todo {
  /// id
  final int id;

  /// 제목
  final String title;

  /// 간단한 설명
  final String? memo;

  /// 일정 등록 날짜
  final DateTime date;

  /// 시간
  final TimeOfDay? time;

  /// 감정
  final Emotion emotion;

  /// 완료 여부
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.memo,
    required this.date,
    this.time,
    required this.emotion,
    required this.isCompleted,
  });

  /// 서버에서 받은 json 데이터를 Todo 오브젝트로 변환
  factory Todo.fromJson(Map<String, dynamic> json) {
    List<String>? time = json['time']?.split(':');
    return Todo(
      id: json['id'],
      title: json['title'],
      memo: json['memo'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      time: time != null
          ? TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]))
          : null,
      emotion: Emotion.fromString(json['emotion']),
      isCompleted: json['isCompleted'],
    );
  }

  /// Todo 오브젝트를 json으로 변환
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'memo': memo,
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'emotion': emotion.name,
      'isCompeted': isCompleted,
    };
  }
}
