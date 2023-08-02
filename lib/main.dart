import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/taskListScreen.dart';
import 'package:todo_list/taskProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do List App',
        home: TaskListScreen(),
      ),
    );
  }
}