import 'package:untitled/model/Exercise/exercise_set.dart';
import 'package:untitled/page/home_pages/exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseSetWidget extends StatelessWidget {
  final ExerciseSet exerciseSet;

  const ExerciseSetWidget({
    required this.exerciseSet,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ExercisePage(exerciseSet: exerciseSet),
    )),
    child: Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
          color: exerciseSet.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: exerciseSet.borderColor,
            width: 3,
          )),
      child: Row(
        children: [
          Expanded(flex: 3, child: buildText()),
          Expanded(child: Image.asset(exerciseSet.imageUrl))
        ],
      ),
    ),
  );

  Widget buildText() {
    final exercises = exerciseSet.exercises.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(exerciseSet.name ,style:GoogleFonts.bebasNeue(
          fontSize: 20,
          letterSpacing: 1,
          color: Colors.black,
        )),
        const SizedBox(height: 10),
        Text('$exercises Egzersiz',style: GoogleFonts.roboto(
          fontSize: 14,
          color: Colors.black,
        ),),
      ],
    );
  }
}