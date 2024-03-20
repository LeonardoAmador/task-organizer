import 'package:flutter/material.dart';
import 'package:task_organizer/screens/form_screen.dart';
import 'package:task_organizer/widgets/task.dart';

class TaskOrganizer extends StatefulWidget {
  const TaskOrganizer({Key? key}) : super(key: key);

  @override
  State<TaskOrganizer> createState() => _TaskOrganizerState();
}

class _TaskOrganizerState extends State<TaskOrganizer> {
  bool isOpacity = true;

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
            onPressed: () {
              setState(() {
                isOpacity = !isOpacity;
              });
            },
            icon: const Icon(Icons.remove_red_eye, color: Colors.white,))
        ],
      ),
      body: AnimatedOpacity(
        opacity: isOpacity ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: [
            Task(
              taskName: 'Sample Task',
              imageUrl: 'assets/images/img01.png',
            ),
            Task(
              taskName: 'Learning Flutter',
              imageUrl: 'assets/images/img01.png',
            ),
            Task(
              taskName: 'Testing',
              imageUrl: 'assets/images/img01.png',
            ),
            Task(
              taskName: 'Practicing',
              imageUrl: 'assets/images/img01.png',
            ),
            Task(
              taskName: 'Here we are',
              imageUrl: 'assets/images/img01.png',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const FormScreen())
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
