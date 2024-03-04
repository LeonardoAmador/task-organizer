import 'package:flutter/material.dart';
import 'package:task_organizer/screens/task_organizer.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskOrganizer(),
    );
  }
}