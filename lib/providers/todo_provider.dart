import 'package:flutter/material.dart';
import 'package:todo_application/models/todo.dart';

class TodoProvider extends ChangeNotifier{
  final List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  void addEntry(String title) {
    _todoList.add(
      Todo(
        title: title,
        id: DateTime.now().toIso8601String(),
        isDone: false,
      ),
    );
    notifyListeners();
  }

  void deleteEntry(int index){
    _todoList.removeAt(index);
    notifyListeners();
  }

  void toggleEntry(int index){
    final todo = _todoList[index];
    todo.isDone = !todo.isDone;
    notifyListeners();
  }
}
