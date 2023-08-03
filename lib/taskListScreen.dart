import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/taskProvider.dart';

import 'constants.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TaskProvider>(context);
    final tasks = tasksProvider.tasks;

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text(
          kTitle,
          style: TextStyle(color: Colors.cyan),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Text(
                tasks[index].title,
                style: TextStyle(
                  fontSize: 18,
                  decoration: tasks[index].isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  color: tasks[index].isCompleted
                      ? Colors.grey
                      : Colors.cyan, // Choose your desired text color
                ),
              ),
              trailing: Checkbox(
                value: tasks[index].isCompleted,
                onChanged: (_) =>
                    tasksProvider.toggleTaskStatus(tasks[index].id),
                activeColor: Colors.green,
              ),
              onLongPress: () => _showDeleteConfirmationDialog(
                  context, tasksProvider, tasks[index].id),
              tileColor: tasks[index].isCompleted
                  ? Colors.grey[300]
                  : Colors
                      .white, // Add some background color to distinguish completed tasks
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ), // Rounded corners for the tile
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal:
                      16), // Adjust padding for better spacing// Show an icon ind
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _showAddTaskDialog(context, tasksProvider),
        child: const Icon(Icons.add, color: Colors.cyan),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskProvider tasksProvider) {
    String newTaskTitle = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          kAddNewTask,
          style: kBoldTextStyle,
        ),
        content: TextField(
          onChanged: (value) => newTaskTitle = value,
          decoration: const InputDecoration(hintText: kEnterTaskTitle),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(kCancel),
          ),
          TextButton(
            onPressed: () {
              tasksProvider.addTask(newTaskTitle);
              Navigator.pop(context);
            },
            child: const Text(kAdd),
          ),
        ],
      ),
    );
  }

  // New method to show a confirmation dialog before deleting a task
  void _showDeleteConfirmationDialog(BuildContext context, TaskProvider tasksProvider, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          kDeleteTask,
          style: kBoldTextStyle,
        ),
        content: Text(
          kVerifyDelete,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(kCancel),
          ),
          TextButton(
            onPressed: () {
              tasksProvider.deleteTask(taskId);
              Navigator.pop(context);
            },
            child: const Text(kDelete),
          ),
        ],
      ),
    );
  }
}
