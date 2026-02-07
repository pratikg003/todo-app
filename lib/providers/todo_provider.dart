import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  TodoProvider() {
    _loadEntries();
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final todos = _todoList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('todos', todos);
    notifyListeners();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedTodos = prefs.getStringList('todos');

    if (savedTodos == null) return;

    _todoList = savedTodos.map((e) => Todo.fromJson(jsonDecode(e))).toList();
    notifyListeners();
  }

  void addEntry(String title) {
    _todoList.add(
      Todo(title: title, id: DateTime.now().toIso8601String(), isDone: false),
    );
    _saveEntries();
    notifyListeners();
  }

  void deleteEntry(int index) {
    _todoList.removeAt(index);
    _saveEntries();
    notifyListeners();
  }

  void toggleEntry(int index) {
    final todo = _todoList[index];
    todo.isDone = !todo.isDone;
    _saveEntries();
    notifyListeners();
  }
}
