import 'package:untitled/model/Calori/CaloriCalculate.dart';


import 'package:untitled/page/inputPages/age_height_weight_input.dart';
import 'package:untitled/page/inputPages/goal_input.dart';
import 'package:untitled/theme/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';


const Color inactiveCard =  Color(0xFF202020);
var exerciseList = [
  "Yeni Başlıyorum.",
  "Hafif Egzersiz (Haftada 1–3 gün antreman yapıyorum. )",
  "Düzenli (Haftada 3–5 gün antreman yapıyorum.)",
  "Ağır Egzersiz (Haftada 6–7 gün antreman yapıyorum.)",
];


class activityModel extends StatefulWidget {

  final double height, weight;
  int age;
  final String gender,firstName,lastName;


  activityModel(
      {Key? key, required this.firstName,
        required this.lastName,
        required this.height,
        required this.weight,
        required this.age,
        required this.gender,
      }) : super(key: key);

  @override
  _activityModelState createState() => _activityModelState();
}

class _activityModelState extends State<activityModel> {
  late int _activity;
  late double height, weight;
  late int age;
  late String gender,firstName,lastName;

  @override
  void initState() {
    firstName=widget.firstName;
    lastName=widget.lastName;
    height = widget.height;
    weight = widget.weight;
    age = widget.age;
    gender = widget.gender;
    super.initState();
  }
  List<bool> isSelected=[true,false,false,false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: back,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left:0.0),
              child: Text("Günlük Aktiviten Ne Kadar?", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.bold,
                  fontSize: 27

              ),),
            ),

            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0),
              child: Text("Sana uygun günlük kaloriyi hesaplayabilmek "
                  "için günlük aktivite "
                  "bilgine ihtiyacımız var.", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.w300,
                  fontSize: 20
              ),),
            ),
            const SizedBox(height: 40,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width:20,),


                ToggleButtons(
                  isSelected: isSelected,
                  selectedColor: web,
                  color: Colors.black,
                  fillColor: white,
                  renderBorder: false,
                  direction: Axis.vertical,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(bottom:10.0),
                      child: Ink(

                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 60,
                        width: 340,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: oxford,
                              width: 3,
                            )),

                        child: Row(
                          children: [
                            const Expanded(flex:0,child: Icon(Icons.male,size: 30,)),
                            const SizedBox(width: 5,),
                            Expanded(child:Text(exerciseList[0],style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),

                          ],
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:10.0),
                      child: Ink(
                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 60,
                        width: 340,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: oxford,
                              width: 3,
                            )),
                        child: Row(
                          children: [
                            const Expanded(flex:0,child: Icon(Icons.male,size: 30,)),
                            const SizedBox(width: 5,),
                            Expanded(child:Text(exerciseList[1],style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),

                          ],
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:10.0),
                      child: Ink(
                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 60,
                        width: 340,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: oxford,
                              width: 3,
                            )),
                        child: Row(
                          children: [
                            const Expanded(flex:0,child: Icon(Icons.male,size: 30,)),
                            const SizedBox(width: 5,),
                            Expanded(child:Text(exerciseList[2],style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),

                          ],
                        ),

                      ),
                    ),
                    Ink(
                      padding: const EdgeInsets.only(right:20,left: 20),
                      height: 60,
                      width: 340,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: oxford,
                            width: 3,
                          )),
                      child: Row(
                        children: [
                          const Expanded(flex:0,child: Icon(Icons.male,size: 30,)),
                          const SizedBox(width: 5,),
                          Expanded(child:Text(exerciseList[3],style: GoogleFonts.roboto(
                            fontSize:20,
                            fontWeight: FontWeight.w600,

                          ),)),

                        ],
                      ),

                    ),


                  ],
                  onPressed: (int newIndex){
                    setState(() {
                      for(int index=0;index<isSelected.length;index++){
                        if(index==newIndex){
                          isSelected[index]=true;
                          _activity=index;
                          print(_activity);
                        }
                        else{
                          isSelected[index]=false;
                        }

                      }
                    });
                  },
                ),


              ],
            ),

            const SizedBox(height: 30,),


            SizedBox(
                height: 50,
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){


                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  GoalPage(
                              firstName: firstName,
                              lastName: lastName,
                              height:height ,
                              weight: weight,
                              gender: gender,
                              age:age,
                              activity: _activity,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    oxford,black
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.arrow_forward_sharp,color: white,),
                              SizedBox(width: 5,),
                              Text("Devam",style: TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }


}
