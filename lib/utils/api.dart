import 'package:chagok/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class API {
  final SupabaseClient supabase = Supabase.instance.client;

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
        .select('id, title, memo, date, time, emotion, isCompleted')
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
      int index = todoDate.weekday;
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
}
