import 'package:flutter/material.dart';

/// `DateTime.weekday`를 `String` 형식으로 변환
String weekdayToString(int weekday) {
  const List<String> weekdays = [
    '월요일',
    '화요일',
    '수요일',
    '목요일',
    '금요일',
    '토요일',
    '일요일',
  ];
  return weekdays[weekday - 1];
}

/// `TimeOfDay`를 `HH:mm` 형식으로 변환
String timeOfDayToString(TimeOfDay timeOfDay) {
  return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
}
