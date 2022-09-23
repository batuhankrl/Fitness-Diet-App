import 'dart:ui';

import 'package:untitled/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:untitled/page/root_app.dart';
import 'package:untitled/page/auth/forgot_password_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController=TextEditingController();




  @override
  void dispose(){
    _emailController.dispose();

    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim()
      );
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context,
          builder: (context){
            return  AlertDialog(
              content: Text("Var olmayan bir e-mail adresi girdiniz",style: GoogleFonts.roboto(
                fontSize: 16,
                color:oxford,

              )),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Şifreni Sıfırlamak İçin Emailini Gir",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize:25,
                        color: oxford,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),

                    //Email TextField
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgTextField,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          children: [
                            Icon(LineIcons.envelope,color: black.withOpacity(0.5),),
                            const SizedBox(width: 15,),
                            Flexible(
                              child: TextField(
                                controller: _emailController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: const InputDecoration(
                                  hintText: "Email",

                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                  ],
                ),


                // reset button

                SizedBox(
                    height: (size.height - 60) * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            passwordReset();

                          },
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
                                Text("Gönder",style: TextStyle(
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}