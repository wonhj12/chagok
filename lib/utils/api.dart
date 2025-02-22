import 'package:chagok/models/todo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class API {
  final SupabaseClient supabase = Supabase.instance.client;

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

    return todos;
  }
}
