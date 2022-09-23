import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/model/Exercise/exercise.dart';
import 'package:untitled/model/Exercise/exercise_set.dart';
import 'package:untitled/widget/video_controls_widget.dart';
import 'package:untitled/widget/video_player_widget.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  final ExerciseSet exerciseSet;

  const ExercisePage({
    required this.exerciseSet,
  });

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final controller = PageController();
  late Exercise currentExercise;

  @override
  void initState() {
    super.initState();

    currentExercise = widget.exerciseSet.exercises.first;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(currentExercise.name.toString()),
        centerTitle: true,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          buildVideos(),
          Positioned(
            bottom: 20,
            right: 50,
            left: 50,
            child: buildVideoControls(),
          )
        ],
      ),
    );
  }
  Widget buildVideos() => PageView(
    controller: controller,
    onPageChanged: (index) => setState(() {
      currentExercise = widget.exerciseSet.exercises[index];
    }),
    children: widget.exerciseSet.exercises
        .map((exercise) => VideoPlayerWidget(
      exercise: exercise,
      onInitialized: () => setState(() {}),
    ))
        .toList(),
  );

  Widget buildVideoControls() => VideoControlsWidget(
    exercise: currentExercise,
    onTogglePlaying: (isPlaying) {
      setState(() {
        if (isPlaying) {
          currentExercise.controller!.play();
        } else {
          currentExercise.controller!.pause();
        }
      });
    },
    onNextVideo: () => controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    ),
    onRewindVideo: () => controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    ),
  );
}