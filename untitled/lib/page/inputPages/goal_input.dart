
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/model/Calori/CaloriCalculate.dart';
import 'package:untitled/page/root_app.dart';
import 'package:untitled/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/model/User/UserData.dart';

var goalList = [
  "Kilomu korumak istiyorum.",
  "Kilo vermek istiyorum.",
  "Kilo almak istiyorum.",
];

class GoalPage extends StatefulWidget {
  final double height, weight;
  final int age,activity;
  final String gender,firstName,lastName;


  const GoalPage(
      {
        required this.firstName,
        required this.lastName,
        required this.height,
        required this.weight,
        required this.age,
        required this.gender,
        required this.activity
      });

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {



  late int _goal;
  late double height, weight;
  late int age,activity;
  late String gender;
  late String firstName,lastName;

  @override
  void initState() {
    firstName=widget.firstName;
    lastName=widget.lastName;
    height = widget.height;
    weight = widget.weight;
    age = widget.age;
    gender = widget.gender;
    activity=widget.activity;
    super.initState();
  }

  List<bool> isSelected=[true,false,false];
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: back,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Text("Hedefin Ne?", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.bold,
                  fontSize: 29

              ),),
            ),

            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0),
              child: Text("Sana uygun günlük kaloriyi hesaplayabilmek "
                  "için hedef "
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
                  selectedColor:web,
                  color: Colors.black,
                  fillColor: white,
                  renderBorder: false,
                  direction: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,bottom:10.0),
                      child: Ink(
                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 50,
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
                            Expanded(child:Text(goalList[0],style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,bottom:10.0),
                      child: Ink(
                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 50,
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
                            Expanded(child:Text(goalList[1],style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),

                          ],
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,bottom:10.0),
                      child: Ink(
                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 50,
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
                            Expanded(child:Text(goalList[2],style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),
                          ],
                        ),
                      ),
                    ),
                  ],
                  onPressed: (int newIndex){
                    setState(() {
                      for(int index=0;index<isSelected.length;index++){
                        if(index==newIndex){
                          isSelected[index]=true;
                          _goal=index;
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


            const SizedBox(height: 110,),
            SizedBox(
                height: 50,
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        createUser(
                            firstName,
                            lastName,
                            gender,
                            age,
                            height,
                            weight,
                            activity,
                            _goal
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
  Future createUser(String firstName,String lastName,String gender,int age,double height,double weight,int activty,int goal) async{
    final docUser=FirebaseFirestore.instance.collection('users').doc();

    final user=UserData(
      id:docUser.id,
      firstName:firstName,
      lastName: lastName,
      gender: gender,
      age:age,
      height:height,
      weight:weight,
      activity:activity,
      goal:_goal,
    );
    final json=user.toJson();

    await docUser.set(json);

  }

}


