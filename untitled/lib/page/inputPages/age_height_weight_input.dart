import 'package:untitled/page/root_app.dart';
import 'package:untitled/page/inputPages/activity_input.dart';
import 'package:flutter/material.dart';
import 'package:untitled/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';


class InputPage extends StatefulWidget {

  final String gender,firstName,lastName;

  InputPage(
      {
        required this.gender,
        required this.firstName,
        required this.lastName,
      });


  @override
  _InputPageState createState() => _InputPageState();
}

// ignore: camel_case_types
class _InputPageState extends State<InputPage> {

  late String gender,firstName,lastName;
  var age=20;
  var weight=50.0;
  var height=160.0;

  @override
  void initState() {
    gender = widget.gender;
    firstName=widget.firstName;
    lastName=widget.lastName;
    super.initState();
  }


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
              child: Text("Detaylı Fizyolojik Bilgi", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.bold,
                  fontSize: 31

              ),),
            ),

            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0),
              child: Text("Sana uygun günlük kaloriyi hesaplayabilmek "
                  "için fizyolojik "
                  "bilgilerine ihtiyacımız var.", style: GoogleFonts.roboto(
                  color:Colors.black,
                  fontWeight:FontWeight.w300,
                  fontSize: 21
              ),),
            ),
            const SizedBox(height: 40,),

            Row(
              children: const [
                Flexible(
                  child: Divider(
                    thickness: 0.8,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {

                        return Container(
                          height: 300,
                          color: platinium,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Yaş",style: GoogleFonts.roboto(
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ),),
                                const SizedBox(height: 10,),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                NumberPicker(
                                  minValue: 15,
                                  maxValue: 65,
                                  value: age,
                                  onChanged:(value){
                                    age=value;

                                  },
                                  selectedTextStyle: GoogleFonts.roboto(
                                    fontSize: 30,
                                    color: oxford,
                                  ),

                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: (() => Navigator.pop(context)),
                                  child: Container(
                                    height: 50,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              oxford,black
                                            ]
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text("Kaydet",style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.only(right:20,left: 20),
                    height: 50,
                    width: 375,
                    decoration: BoxDecoration(
                        color: back,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: back,
                          width: 3,
                        )),
                    child: Row(
                      children: [
                        Expanded(child:Text("Yaş",style: GoogleFonts.roboto(
                          fontSize:20,
                          fontWeight: FontWeight.w600,

                        ),)),
                        const SizedBox(width: 190,),
                        Expanded(child:Text("$age",style: GoogleFonts.roboto(
                          fontSize:20,
                          fontWeight: FontWeight.w400,

                        ),)),
                        const Expanded( flex:1,child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: const [
                    Flexible(
                      child: Divider(
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300,
                          color: platinium,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Kilo",style: GoogleFonts.roboto(
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ),),
                                const SizedBox(height: 10,),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                DecimalNumberPicker(
                                  minValue: 20,
                                  maxValue: 150,
                                  value: weight,
                                  onChanged:(value){
                                    weight=value;

                                  },
                                  selectedTextStyle: GoogleFonts.roboto(
                                    fontSize: 30,
                                    color: oxford,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              oxford,black
                                            ]
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text("Kaydet",style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                    );

                  },
                  child: Container(
                    padding: const EdgeInsets.only(right:20,left: 20),
                    height: 60,
                    width: 375,
                    decoration: BoxDecoration(
                        color: back,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: back,
                          width: 3,
                        )),
                    child: Row(
                      children: [
                        Expanded(child:Text("Kilo",style: GoogleFonts.roboto(
                          fontSize:20,
                          fontWeight: FontWeight.w600,

                        ),)),
                        const SizedBox(width: 190,),
                        Expanded(child:Text("$weight",style: GoogleFonts.roboto(
                          fontSize:20,
                          fontWeight: FontWeight.w400,

                        ),)),
                        const Expanded( flex:1,child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),

                  ),
                ),

                Row(
                  children: const [
                    Flexible(
                      child: Divider(
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: (){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300,
                          color: platinium,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Boy",style: GoogleFonts.bebasNeue(
                                  fontSize:20,
                                  letterSpacing: 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                ),),
                                const SizedBox(height: 10,),
                                Row(
                                  children: const [
                                    Flexible(
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                DecimalNumberPicker(
                                  haptics: true,
                                  minValue: 120,
                                  maxValue: 210,
                                  value: height,
                                  onChanged:(value){
                                    height=value;

                                  },
                                  selectedTextStyle: GoogleFonts.bebasNeue(
                                    fontSize: 30,
                                    color: oxford,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: Container(
                                    height: 50,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              oxford,black
                                            ]
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text("Kaydet",style: GoogleFonts.bebasNeue(
                                            fontSize: 22,
                                            color: white,
                                            fontWeight: FontWeight.bold
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right:20,left: 20),
                    height: 60,
                    width: 375,
                    decoration: BoxDecoration(
                        color: back,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: back,
                          width: 3,
                        )),
                    child: Row(
                      children: [

                        Expanded(child:Text("Boy",style: GoogleFonts.roboto(
                          fontSize:20,
                          fontWeight: FontWeight.w600,

                        ),)),
                        const SizedBox(width: 160,),
                        Expanded(child:Text("$height",style: GoogleFonts.roboto(
                          fontSize:20,
                          fontWeight: FontWeight.w400,

                        ),)),
                        const Expanded( flex:1,child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),

                  ),
                ),

                Row(
                  children: const [
                    Flexible(
                      child: Divider(
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50,),

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
                                builder: (context) =>  activityModel(
                                  firstName: firstName,
                                  lastName: lastName,
                                  height:height ,
                                  weight: weight,
                                  gender: gender,
                                  age:age,
                                ),
                              ),
                            );
                            print(gender);
                            print(age);
                            print(height);
                            print(weight);
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
          ],
        ),
      ),
    );
  }
}
