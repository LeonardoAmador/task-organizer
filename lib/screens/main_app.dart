import 'package:flutter/material.dart';
import 'package:task_organizer/data/task_inherited.dart';
import 'package:task_organizer/screens/task_organizer.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: TaskInherited(child: const TaskOrganizer())
    );
  }
}