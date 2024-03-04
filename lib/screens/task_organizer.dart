import 'package:flutter/material.dart';
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
      ),
      body: AnimatedOpacity(
        opacity: isOpacity ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          children: [
            Task(
              taskName: 'Sample Task',
              imageUrl:
                  'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
            ),
            Task(
              taskName: 'Learning Flutter',
              imageUrl:
                  'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
            ),
            Task(
              taskName: 'Testing',
              imageUrl:
                  'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
            ),
            Task(
              taskName: 'Practicing',
              imageUrl:
                  'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
            ),
            Task(
              taskName: 'Here we are',
              imageUrl:
                  'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isOpacity = !isOpacity;
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.remove_red_eye,
          color: Colors.white,
        ),
      ),
    );
  }
}