import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/task.dart';

import 'constants.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks]; //using spread operator (...) to insert all the elements of _tasks into tasks

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(newTask);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskStatus(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex >= 0) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      _saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    _saveTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = _tasks.map((task) => task.toJson()).toList();
    await prefs.setString(kTasksKey, json.encode(encodedTasks));
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTasks = prefs.getString(kTasksKey);
    if (storedTasks != null) {
      final decodedTasks = json.decode(storedTasks) as List<dynamic>;
      _tasks = decodedTasks.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    }
  }
}
