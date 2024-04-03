import 'package:flutter/material.dart';
import 'package:task_organizer/data/task_inherited.dart';
import 'package:task_organizer/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isOpacity = true;

  void reloadScreen() {
    setState(() {
      isOpacity = !isOpacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Organizer',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: reloadScreen,
            icon: const Icon(Icons.refresh, color: Colors.white), 
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: TaskInherited.of(context).taskList.length,
          itemBuilder: (context, index) {
            return TaskInherited.of(context).taskList[index];
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (newContext) => FormScreen(taskContext: context,))
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
