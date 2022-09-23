import 'dart:ui';

import 'package:untitled/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:untitled/page/root_app.dart';
import 'package:untitled/page/auth/forgot_password_page.dart';


class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({Key? key,required this.showRegisterPage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  final auth=FirebaseAuth.instance;

  Future signIn() async{

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),

    );

    try{
      print("login firestore çalıştı");
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),

      );
    } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) =>route.isFirst);

  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  showSnackBar(String? text){
    if(text==null) return;
    final snackBar= SnackBar(content: Text(text),backgroundColor: Colors.white,);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }


  final navigatorKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
    );

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
          child: Column(
            children: [
                    const Text(
                      "Merhaba,",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Tekrar Hoşgeldin",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
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
                                    border: InputBorder.none
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //Şifre TextField
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgTextField,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(LineIcons.lock,color: black.withOpacity(0.5),),
                            const SizedBox(width: 15,),
                            Flexible(
                              child: TextField(
                                obscureText: true,
                                controller: _passwordController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: const InputDecoration(
                                    hintText: "Şifre",
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            IconButton(onPressed: (){

                            }, icon: Icon(LineIcons.eyeAlt,color: black.withOpacity(0.5),))
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //Kayıt Ol TextField
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Hesabın Yok Mu?",style: GoogleFonts.roboto(
                          fontSize: 15,

                        ),),

                        const SizedBox(width: 5,),

                        GestureDetector(
                          onTap: widget.showRegisterPage,

                          child:  Text("Şimdi Kayıt Ol",style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: oxford,
                            fontWeight: FontWeight.bold,

                          ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const ForgotPasswordPage();
                        }));
                      },
                      child: const Text("Şifremi Unuttum?",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,

                      ),),
                    ),

                     const SizedBox(height: 10,),

                      GestureDetector(
                        onTap: (){
                          signIn();
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
                              Text("Başla",style: TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Flexible(
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text("Ya da"),
                          SizedBox(width: 5,),
                          Flexible(
                            child: Divider(
                              thickness: 0.8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: black.withOpacity(0.1)
                                )
                            ),
                            child: Center(
                              child: SvgPicture.asset("assets/google_icon.svg",width: 20,),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: black.withOpacity(0.1)
                                )
                            ),
                            child: Center(
                              child: SvgPicture.asset("assets/facebook_icon.svg",width: 20,),
                            ),
                          )
                        ],
                      )

            ],
          ),
        ),
      ),
    );
  }
}