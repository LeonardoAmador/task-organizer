import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Task Organizer',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: const [
            Task(taskName: 'Sample Task', imageUrl: 'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large'),
            Task(taskName: 'Learning Flutter', imageUrl: 'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large'),
            Task(taskName: 'Testing', imageUrl: 'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large'),
            Task(taskName: 'Practing', imageUrl: 'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large'),
            Task(taskName: 'Here we are', imageUrl: 'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add onPressed action for FAB
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String taskName;
  final String imageUrl;

  const Task({required this.taskName, required this.imageUrl, Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int level = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            color: Colors.blue,
            height: 140,
          ),
          Column(
            children: [
              Container(
                color: Colors.white,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.black26,
                      width: 72,
                      height: 100,
                      child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(widget.taskName,
                          style: const TextStyle(
                              fontSize: 18, overflow: TextOverflow.ellipsis)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          level++;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_up,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: level/10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Level: $level',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
