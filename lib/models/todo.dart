import 'package:chagok/utils/enums/emotion.dart';
import 'package:flutter/material.dart';

class Todo {
  /// id
  final int id;

  /// 제목
  String title;

  /// 간단한 설명
  String? memo;

  /// 일정 등록 날짜
  DateTime date;

  /// 시간
  TimeOfDay? time;

  /// 감정
  Emotion emotion;

  /// 완료 여부
  bool isCompleted;

  /// 알림 여부
  bool isAlarm;

  Todo({
    required this.id,
    required this.title,
    this.memo,
    required this.date,
    this.time,
    required this.emotion,
    required this.isCompleted,
    required this.isAlarm,
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
      isAlarm: json['isAlarm'] ?? false,
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
      'isCompleted': isCompleted,
      'isAlarm': isAlarm,
    };
  }

  /// Todo 수정
  void updateTodo({
    String? title,
    String? memo,
    DateTime? date,
    TimeOfDay? time,
    bool? clearTime,
    Emotion? emotion,
    bool? isCompleted,
    bool? isAlarm,
  }) {
    // 주어진 값이 있으면 수정, 없으면 기존 데이터 그대로 유지
    this.title = title ?? this.title;
    this.memo = memo ?? this.memo;
    this.date = date ?? this.date;
    this.time = clearTime ?? false ? null : time ?? this.time;
    this.emotion = emotion ?? this.emotion;
    this.isCompleted = isCompleted ?? this.isCompleted;
    this.isAlarm = isAlarm ?? this.isAlarm;
  }
}
