

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/model/User/UserData.dart';
import 'package:untitled/theme/colors.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/model/User/User.dart';
import 'package:untitled/widget/ProfileWidget.dart';
import 'package:untitled/model/User/user_prefences.dart';
import 'package:untitled/model/Calori/CaloriCalculate.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  var user=FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
   const user1=UserPrefences.myUser;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF14213D),
        title:Text("C  H  A  I  N  G  E",style:GoogleFonts.bebasNeue(
          fontSize: 25,
          letterSpacing: 0.2,
        )),
        centerTitle: true,
        leading: const Icon(Icons.fitness_center),
        actions: [
          IconButton(
            icon: const Icon( Icons.logout,color: white,size: 30, ),
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
          ),
          const SizedBox(width:12),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:user1.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24,),
          //buildName(user),

          const SizedBox(height: 50,),

          FutureBuilder<UserData?>(
              future: readUsers(),
              builder: ((context, snapshot) {
                if(snapshot.hasData){
                  final user=snapshot.data;
                  return user==null ?
                  const Center(child: Text("No Users")) : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            height: 125,
                            width: 170,
                            decoration: BoxDecoration(
                              color: platinium,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Güncel Kilo",style: GoogleFonts.roboto(
                                      color:oxford,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                                    const SizedBox(width: 10,),
                                    const Icon(Icons.edit,color: web,size: 25,),
                                  ],
                                ),
                                const SizedBox(height: 25,),

                                Text("${user.weight}",style: GoogleFonts.roboto(
                                  color:web,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                              ],
                            ),
                          ),


                          Container(
                            padding: const EdgeInsets.all(16),
                            height: 125,
                            width: 170,
                            decoration: BoxDecoration(
                              color: platinium,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Boy",style: GoogleFonts.roboto(
                                      color:oxford,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                                    const SizedBox(width: 75,),
                                    const Icon(Icons.edit,color: web,size: 25,),
                                  ],
                                ),
                                const SizedBox(height: 25,),

                                Text("${user.height}",style: GoogleFonts.roboto(
                                  color:web,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }

              })
          ),


          const SizedBox(height: 20,),

          FutureBuilder<UserData?>(
              future: readUsers(),
              builder: ((context, snapshot) {
                if(snapshot.hasData){
                  final user=snapshot.data;
                  return user==null ?
                  const Center(child: Text("No Users")) : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            height: 125,
                            width: 170,
                            decoration: BoxDecoration(
                              color: platinium,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("BMI",style: GoogleFonts.roboto(
                                      color:oxford,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                                    const SizedBox(width: 75,),
                                    const Icon(Icons.info,color: web,size: 25,),
                                  ],
                                ),
                                const SizedBox(height: 25,),
                                Text(Calculate().calculateBMI(user),style: GoogleFonts.roboto(
                                  color:web,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(16),
                            height: 125,
                            width: 170,
                            decoration: BoxDecoration(
                              color: platinium,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Hedef Kalori",style: GoogleFonts.roboto(
                                  color:oxford,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                                const SizedBox(height: 25,),
                                Text(Calculate().getCalori(user),style: GoogleFonts.roboto(
                                  color:web,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              })
          ),

        ],
      ),


    );

  }

  Future<UserData?> readUsers() async{
    final docUser=FirebaseFirestore.instance.collection('users').doc(user!.uid);

    final snapshot=await docUser.get();

    if(snapshot.exists){
      return UserData.fromJson(snapshot.data()!);
    }

  }

}