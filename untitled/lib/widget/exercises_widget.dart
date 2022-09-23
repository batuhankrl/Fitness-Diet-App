import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/data/exercise_sets.dart';
import 'package:untitled/model/User/User.dart';
import 'package:untitled/model/User/UserData.dart';
import 'package:untitled/model/Exercise/exercise_set.dart';
import 'package:untitled/widget/exercise_set_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ExercisesWidget extends StatefulWidget {
  const ExercisesWidget({Key? key}) : super(key: key);

  @override
  State<ExercisesWidget> createState() => _ExercisesWidgetState();
}

class _ExercisesWidgetState extends State<ExercisesWidget> {
  ExerciseType selectedType = ExerciseType.low;

  var user=FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    FutureBuilder<UserData?>(
        future: readUsers(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            final user=snapshot.data;
            return user==null ?
            const Center(child: Text("No Users")) : Container(
              color: Colors.white,
              padding:const EdgeInsets.only(top:20,right: 10,bottom:10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ListTile(
                    title: Text("Merhaba, ${user.firstName}",style:GoogleFonts.bebasNeue(
                      fontSize:20,
                      letterSpacing: 0.5,
                      color:Colors.black,
                    )),
                    subtitle: Text("Antreman Planını Hazırla",style:GoogleFonts.bebasNeue(
                      fontSize: 25,
                      letterSpacing: 0.5,
                      color: Colors.black,
                    )),
                    trailing: ClipOval(child: Image.asset("assets/default-avatar.jpg")),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }

        })
    );
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver:
      SliverList(
        delegate: SliverChildListDelegate(
          [

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child:Text("Egzersizler",style:GoogleFonts.bebasNeue(
                fontSize: 24,
                letterSpacing: 1,
                color: Colors.black,
              )),
            ),
            const SizedBox(height: 8),
            buildDifficultyLevel(),
            const SizedBox(height: 8),
            buildWorkouts(),

          ],
        ),
      ),

    );

  }
  Widget buildWorkouts() => GestureDetector(
    onHorizontalDragEnd: swipeFunction,
    child: SingleChildScrollView(
      child: Column(
        children: exerciseSets
            .where((element) => element.exerciseType == selectedType)
            .map(
              (exerciseSet) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ExerciseSetWidget(exerciseSet: exerciseSet)),
        )
            .toList(),
      ),
    ),
  );

  Widget buildDifficultyLevel() => Row(
    children: ExerciseType.values.map(
          (type) {
        final name = getExerciseName(type);
        final fontWeight =
        selectedType == type ? FontWeight.bold : FontWeight.normal;

        return Expanded(
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => selectedType = type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(name ,style:GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: fontWeight,
                  color: Colors.black,
                )),
              ),
            ),
          ),
        );
      },
    ).toList(),
  );

  void swipeFunction(DragEndDetails dragEndDetails) {
    final selectedIndex = ExerciseType.values.indexOf(selectedType);
    final hasNext = selectedIndex < ExerciseType.values.length;
    final hasPrevious = selectedIndex > 0;

    setState(() {
      if (dragEndDetails.primaryVelocity! < 0 && hasNext) {
        final nextType = ExerciseType.values[selectedIndex + 1];
        selectedType = nextType;
      }
      if (dragEndDetails.primaryVelocity! > 0 && hasPrevious) {
        final previousType = ExerciseType.values[selectedIndex - 1];
        selectedType = previousType;
      }
    });
  }


  Future<UserData?> readUsers() async{
    final docUser=FirebaseFirestore.instance.collection('users').doc(user!.uid);

    final snapshot=await docUser.get();

    if(snapshot.exists){
      return UserData.fromJson(snapshot.data()!);
    }



  }

}