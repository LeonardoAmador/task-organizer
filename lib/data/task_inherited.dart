import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_organizer/widgets/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final taskList = <Task>[];

  void addNewTask(String taskName, String imageUrl, int difficultyRating) {
    taskList.add(Task(taskName: taskName, imageUrl: imageUrl, difficultyRating: difficultyRating));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType();
    assert(result != null, 'No TaskInherited found in context');

    return result!;
  }
  
  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return !listEquals(oldWidget.taskList, taskList);
  }
}