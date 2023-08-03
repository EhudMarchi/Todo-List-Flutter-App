import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/taskListScreen.dart';
import 'package:todo_list/taskProvider.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kTitle,
        home: TaskListScreen(),
      ),
    );
  }
}