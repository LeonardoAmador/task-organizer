import 'package:flutter/material.dart';
import 'package:task_organizer/components/task.dart';
import 'package:task_organizer/models/task_dao.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    Text('Loading')
                  ]),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    Text('Loading')
                  ]),
                );
              case ConnectionState.active:
                return const Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    Text('Loading')
                  ]),
                );
              case ConnectionState.done:
                if (snapshot.hasData) {
                  List<Task>? items = snapshot.data;
                  if (items != null && items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final Task task = items[index];
                        return task;
                      },
                    );
                  } else {
                    return const Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'There are no tasks',
                            style: TextStyle(fontSize: 32),
                          )
                        ],
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('Unknown Error');
                }
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (newContext) => FormScreen(
                        taskContext: context,
                  )
              )
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
