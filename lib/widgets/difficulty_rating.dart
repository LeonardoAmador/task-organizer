import 'package:flutter/material.dart';

class DifficultyRating extends StatelessWidget {
  final int difficultyRating;
  final ValueChanged<int> onRatingChanged;

  const DifficultyRating({super.key, 
    required this.difficultyRating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            onRatingChanged(index + 1);
          },
          child: Icon(
            index < difficultyRating ? Icons.star : Icons.star_border,
            size: 15,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}