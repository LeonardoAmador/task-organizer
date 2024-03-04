import 'package:flutter/material.dart';
import 'package:task_organizer/widgets/difficulty_rating.dart';

// ignore: must_be_immutable
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
              _buildTaskDetails(),
              _buildLevelIndicator(),
            ],
          ),
        ],
      ),
    );
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
      child: Image.network(widget.imageUrl, fit: BoxFit.cover),
    );
  }

  Widget _buildTaskInfo() {
    return Expanded(
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
