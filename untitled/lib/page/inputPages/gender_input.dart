
import 'package:untitled/page/inputPages/age_height_weight_input.dart';
import 'package:untitled/page/inputPages/goal_input.dart';
import 'package:untitled/theme/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/page/inputPages/activity_input.dart';
import 'package:google_fonts/google_fonts.dart';



class GenderPage extends StatefulWidget {

  final String firstName;
  final String lastName;


  const GenderPage({Key? key,required this.firstName,required this.lastName});


  @override
  _GenderPageState createState() => _GenderPageState();
}

// ignore: camel_case_types
class _GenderPageState extends State<GenderPage> {

  late String firstName;
  late String lastName;
  String gender="";

  @override
  void initState() {
    firstName = widget.firstName;
    lastName = widget.lastName;
    super.initState();
  }



  List<bool> isSelected=[true,false];


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
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
              child: Text("Cinsiyetin Nedir?", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.bold,
                  fontSize: 31

              ),),
            ),

            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0),
              child: Text("Sana uygun günlük kaloriyi hesaplayabilmek "
                  "için cinsiyet "
                  "bilgine ihtiyacımız var.", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.w300,
                  fontSize: 21
              ),),
            ),
            const SizedBox(height: 40,),




            Row(
              children: [
                const SizedBox(width:30,),


                ToggleButtons(

                  isSelected: isSelected,
                  selectedColor: web,
                  color: Colors.black,
                  fillColor: white,
                  renderBorder: false,

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Ink(
                        padding: const EdgeInsets.only(right:20,left: 20),
                        height: 160,
                        width: 140,
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: web,
                              width: 3,
                            )),
                        child: Column(
                          children: [
                            const Expanded(flex:3,child: Icon(Icons.female,size: 50,)),

                            Expanded(child:Text("Kadın",style: GoogleFonts.roboto(
                              fontSize:20,
                              fontWeight: FontWeight.w600,

                            ),)),

                          ],
                        ),

                      ),

                    ),


                    Ink(
                      padding: const EdgeInsets.only(right:20,left: 20),
                      height: 160,
                      width: 140,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: oxford,
                            width: 3,
                          )),
                      child: Column(
                        children: [
                          const Expanded(flex:3,child: Icon(Icons.male,size: 50,)),

                          Expanded(child:Text("Erkek",style: GoogleFonts.roboto(
                            fontSize:20,
                            fontWeight: FontWeight.w600,

                          ),)),
                        ],
                      ),
                    ),
                  ],
                  onPressed: (int newIndex){
                    setState(() {
                      for(int index=0; index<isSelected.length; index++){
                        if(index==newIndex){
                          isSelected[index]=true;
                          gender="Erkek";
                          print(gender);
                        }
                        else{
                          isSelected[index]=false;
                          gender="Kadın";
                          print(gender);
                        }
                      }
                    });
                  },
                ),





              ],
            ),

            const SizedBox(height: 100,),
            SizedBox(
                height: 50,
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>InputPage(gender: gender,firstName: firstName,lastName: lastName,)));
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

