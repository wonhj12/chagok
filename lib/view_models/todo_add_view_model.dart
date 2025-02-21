import 'package:chagok/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoAddViewModel with ChangeNotifier {
  TodoModel todoModel;
  BuildContext context;
  TodoAddViewModel({required this.todoModel, required this.context});
}
