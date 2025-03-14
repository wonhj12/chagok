import 'package:chagok/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class API {
  final SupabaseClient supabase = Supabase.instance.client;

  /// 주어진 날짜가 포함된 월에 있는 일정 날짜들을 가져오는 get 요청
  /// <br /> 달력에 표시할 마커로 사용하기 위해 set로 변환
  Future<Set<DateTime>> getMarkers(DateTime date) async {
    // 월의 시작일과 마지막일 계산
    final int start =
        DateTime(date.year - 1, date.month, 1).millisecondsSinceEpoch;
    final int end =
        DateTime(date.year + 1, date.month + 1, 1).millisecondsSinceEpoch - 1;

    // 선택된 날짜가 포함된 월의 모든 일정 날짜 가져오기
    final List<Map<String, dynamic>> response = await supabase
        .from('todo')
        .select('date')
        .gte('date', start)
        .lte('date', end - 1);

    // 마커 초기화
    Set<DateTime> markers = {};

    for (Map<String, dynamic> item in response) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(item['date']);
      markers.add(DateTime(date.year, date.month, date.day));
    }

    return markers;
  }

  /// 주어진 날짜가 포함된 주의 일정을 가져오는 get 요청
  /// <br /> 요일에 맞춰 길이 7의 배열로 반환
  Future<List<List<Todo>>> getTodos(DateTime date) async {
    // 선택된 날짜가 포함된 주의 일요일, 토요일 값 반환
    // 일요일
    DateTime sunday = DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: date.weekday % 7));
    // 토요일
    DateTime saturday = DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: date.weekday % 7))
        .add(Duration(
            days: 6, hours: 23, minutes: 59, seconds: 59, milliseconds: 999));

    int start = sunday.millisecondsSinceEpoch;
    int end = saturday.millisecondsSinceEpoch;

    // 선택된 날짜가 포함된 주의 모든 일정 받아오기
    final List<Map<String, dynamic>> response = await supabase
        .from('todo')
        .select('id, title, memo, date, time, emotion, isCompleted, isAlarm')
        .gte('date', start)
        .lte('date', end)
        .order('time', ascending: true, nullsFirst: false)
        .order('date', ascending: true);

    // 일정 배열 초기화
    List<List<Todo>> todos = List.generate(7, (_) => <Todo>[]);

    // response가 없으면 일주일 7일 각각 빈 배열 반환
    if (response.isEmpty) {
      return todos;
    }

    // 요일에 맞춰서 배열에 일정 추가
    for (Map<String, dynamic> todo in response) {
      // 저장된 date를 int로 받고 DateTime으로 변환
      int milliseconds = todo['date'];
      DateTime todoDate = DateTime.fromMillisecondsSinceEpoch(milliseconds);

      // 요일에 맞춰 추가
      int index = todoDate.weekday % 7;
      todos[index].add(Todo.fromJson(todo));
    }

    debugPrint('getTodo completed: fetched ${response.length} todos');

    return todos;
  }

  /// 일정을 db에 등록하는 post 요청
  /// <br /> 등록 후 등록한 일정을 반환
  Future<Todo> postTodo(Map<String, dynamic> jsonData) async {
    try {
      // db에 새 일정 등록
      final Map<String, dynamic> response =
          await supabase.from('todo').insert(jsonData).select().single();

      debugPrint('postTodo completed');

      return Todo.fromJson(response);
    } catch (e) {
      throw ErrorDescription('Failed to post Todo: $e');
    }
  }

  /// 일정을 수정하는 patch 요청
  /// <br /> 수정이 정상적으로 이루어졌으면 `true` 반환
  Future<bool> patchTodo(int id, Map<String, dynamic> jsonData) async {
    try {
      // 일정 업데이트
      await supabase.from('todo').update(jsonData).eq('id', id);

      debugPrint('patchTodo completed');

      return true;
    } catch (e) {
      throw ErrorDescription('Failed to patch Todo: $e');
    }
  }

  /// 일정을 지우는 delete 요청
  /// <br /> 삭제가 정상적으로 이루어졌으면 `true` 반환
  Future<bool> deleteTodo(int id) async {
    try {
      await supabase.from('todo').delete().eq('id', id);

      debugPrint('deleteTodo completed');

      return true;
    } catch (e) {
      throw ErrorDescription('Failed to delete Todo: $e');
    }
  }
}
