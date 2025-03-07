import 'package:chagok/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// 참고 : https://velog.io/@tygerhwang/Flutter-Local-Notifications-사용해-보기

// 안드로이드 알림 설정
const androidDetails = AndroidNotificationDetails(
  'chagok_notification_channel',
  'chagok_notification',
  priority: Priority.defaultPriority,
  importance: Importance.defaultImportance,
);

// iOS 알림 설정
const iosDetails = DarwinNotificationDetails(
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
);

// 알림
final notifications = FlutterLocalNotificationsPlugin();

/* 권한 설정 */
/// 사용자 권한 확인하는 함수
void _permissionWithNotification() async {
  if (await Permission.notification.isDenied &&
      !await Permission.notification.isPermanentlyDenied) {
    await [Permission.notification].request();
  }
}

/* 알림 설정 */
/// 알림 설정 초기화
void initNotification() async {
  // 알림 권한 확인
  _permissionWithNotification();

  // 안드로이드 권한 요청
  AndroidInitializationSettings android =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  // ios 권한 요청
  // permission_handler를 사용해서 권한 설정하기 때문에 false로 지정
  var iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  // 알림 설정
  var setting = InitializationSettings(android: android, iOS: iosSetting);

  // tz 초기화
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  await notifications.initialize(setting);
}

/// 알림 설정
/// <br /> 현재 시간과 비교 후 미래에 있을 일정인 경우에만 등록
Future<void> setNotification(Todo todo) async {
  // 미래 일정인지 현재 시간과 비교
  if (todo.date
      .copyWith(hour: todo.time?.hour, minute: todo.time?.minute)
      .isAfter(DateTime.now())) {
    // 알림 시간 설정
    tz.TZDateTime date = tz.TZDateTime.from(todo.date, tz.local);
    final schedule = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      todo.time?.hour ?? 12,
      todo.time?.minute ?? 00,
    );

    // 알림 등록
    await notifications.zonedSchedule(
      todo.id,
      todo.title,
      '일정을 확인하세요!',
      schedule,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint('Notification set: ${todo.id}');
  }
}

/// 알림 취소
/// <br /> `int id = Todo.id`
Future<void> cancelNotification(int id) async {
  await notifications.cancel(id);
  debugPrint('Notification canceled: $id');
}
