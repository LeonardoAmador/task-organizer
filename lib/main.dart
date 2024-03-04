import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskOrganizer(),
    );
  }
}

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

class Task extends StatefulWidget {
  final String taskName;
  final String imageUrl;
  int difficultyRating = 0;

  Task({required this.taskName, required this.imageUrl, Key? key})
      : super(key: key);

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(widget.taskName,
                              style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                        Row(
                          children: List.generate(
                              5,
                              (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.difficultyRating = index + 1;
                                      });
                                    },
                                    child: Icon(
                                      index < widget.difficultyRating
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 15,
                                      color: Colors.blue,
                                    ),
                                  )),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          level++;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue)),
                      child: const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
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
                        value: (widget.difficultyRating != 0 &&
                                !level.isNaN &&
                                !level.isInfinite)
                            ? ((level / widget.difficultyRating) / 10)
                            : 0.0,
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
