import 'package:flutter/material.dart';

import 'exercise.dart';

enum ExerciseType { low, mid, hard }

String getExerciseName(ExerciseType type) {
  switch (type) {
    case ExerciseType.hard:
      return 'Zor';

    case ExerciseType.mid:
      return 'Orta';

    case ExerciseType.low:
      return 'Kolay';

    default:
      return 'All';

  }
}

class ExerciseSet {
  final String name;
  final List<Exercise> exercises;
  final String imageUrl;
  final ExerciseType exerciseType;
  final Color color;
  final Color borderColor;

  const ExerciseSet({
    required this.name,
    required this.exercises,
    required this.imageUrl,
    required this.exerciseType,
    required this.color,
    required this.borderColor,
  });

}