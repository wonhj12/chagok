import 'package:chagok/models/todo_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final TodoModel todoModel;
  final BuildContext context;
  HomeViewModel({required this.todoModel, required this.context});
}
