import 'package:untitled/widget/exercises_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor: const Color(0xFF14213D),
        title:Text("C  H  A  I  N  G  E",style:GoogleFonts.bebasNeue(
          fontSize: 25,
          letterSpacing: 0.2,

        )),
        centerTitle: true,
        actions: const [
          Icon( Icons.fitness_center, ),
          SizedBox(width:12),
        ],
      ),

      body: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          ExercisesWidget(),
        ],
      ),
    );
  }
}
