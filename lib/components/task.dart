import 'package:flutter/material.dart';
import 'package:task_organizer/components/difficulty_rating.dart';
import 'package:task_organizer/models/task_dao.dart';

// ignore: must_be_immutable
class Task extends StatefulWidget {
  final String taskName;
  final String imageUrl;
  int difficultyRating = 0;

  Task(
      {required this.taskName,
      required this.imageUrl,
      required this.difficultyRating,
      Key? key})
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
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 140,
          ),
          Column(
            children: [
              _buildTaskDetails(),
              _buildLevelIndicator(),
            ],
          ),
        ],
      ),
    );
  }

  bool assetOrNetwork() {
    if (widget.imageUrl.contains('http')) {
      return false;
    }

    return true;
  }

  Widget _buildTaskDetails() {
    return Container(
      color: Colors.white,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTaskImage(),
          _buildTaskInfo(),
          _buildDifficultyRating(),
        ],
      ),
    );
  }

  Widget _buildTaskImage() {
    return Container(
      color: Colors.black26,
      width: 72,
      height: 100,
      child: assetOrNetwork()
          ? Image.asset(widget.imageUrl, fit: BoxFit.cover)
          : Image.network(widget.imageUrl, fit: BoxFit.cover),
    );
  }

  Widget _buildTaskInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              widget.taskName,
              style: const TextStyle(
                  fontSize: 18, overflow: TextOverflow.ellipsis),
            ),
          ),
          DifficultyRating(
            difficultyRating: widget.difficultyRating,
            onRatingChanged: (rating) {
              setState(() {
                widget.difficultyRating = rating;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyRating() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          level++;
        });
      },
      onLongPress: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Delete Task'),
            content: const Text('Are you sure? '),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  TaskDao().delete(widget.taskName);
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
      ),
      child: const Icon(
        Icons.arrow_drop_up,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLevelIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              color: Colors.white,
              value: calculateProgress(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Level: $level',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  double calculateProgress() {
    return (widget.difficultyRating != 0 && !level.isNaN && !level.isInfinite)
        ? ((level / widget.difficultyRating) / 10)
        : 0.0;
  }
}
