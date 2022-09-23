import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/page/auth/login_page.dart';
import 'package:untitled/page/inputPages/gender_input.dart';
import 'package:untitled/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:untitled/page/root_app.dart';
import 'package:untitled/model/User/User.dart';
import 'package:email_validator/email_validator.dart';


class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({Key? key,required this.showLoginPage }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController=TextEditingController();
  final _firstnameController=TextEditingController();
  final _lastnameController=TextEditingController();
  final navigatorKey=GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();





  Future signUp() async{
    final isValid=formKey.currentState!.validate();
    if(!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),

    );

    try{
      print("singup firestore çalıştı");
      if(passwordConfirmed()){
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        //add user details
        addUserDetails(
            _firstnameController.text.trim(),
            _lastnameController.text.trim()
        );
      }
    } on FirebaseAuthException catch (e){
      print(e);

      showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route)=> route.isFirst);

  }

  Future addUserDetails(String firstname,String lastname) async{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  GenderPage(
          firstName: firstname,
          lastName: lastname,
        ),
      ),
    );




  }

  bool passwordConfirmed(){
    if(_passwordController.text.trim()==_confirmPasswordController.text.trim()){
      return true;
    }
    else{
      return false;
    }
  }
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _confirmPasswordController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }
  showSnackBar(String? text){
    if(text==null) return;
    final snackBar= SnackBar(content: Text(text),backgroundColor: Colors.white,);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

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
          child: Form(
            key:formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text(
                      "Merhaba,",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Hoşgeldin",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //İsim TextField
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
                            Icon(LineIcons.personEnteringBooth,color: black.withOpacity(0.5),),
                            const SizedBox(width: 15,),
                            Flexible(
                              child: TextField(
                                controller: _firstnameController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: const InputDecoration(
                                    hintText: "İsim",
                                    border: InputBorder.none
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //Soyisim TextField
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
                                controller: _lastnameController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: const InputDecoration(
                                    hintText: "Soyisim",
                                    border: InputBorder.none
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                              child: TextFormField(
                                controller: _emailController,
                                cursorColor: black.withOpacity(0.5),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    border: InputBorder.none
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (email)=>
                                email !=null && !EmailValidator.validate(email)
                                    ? 'Geçerli bir mail adresi giriniz'
                                    : null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: const InputDecoration(
                                    hintText: "Şifre",
                                    border: InputBorder.none
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value)=>
                                value !=null && value.length < 6
                                    ? 'Şifre minimum 6 karakter olmalıdır'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Şifre Onay TextField
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
                                controller: _confirmPasswordController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: const InputDecoration(
                                    hintText: "Şifrenizi Onaylayın",
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Üye misin?",style: GoogleFonts.roboto(

                      fontSize: 16,
                    ),),

                    const SizedBox(width: 5,),


                    GestureDetector(
                      onTap: widget.showLoginPage,

                      child:  Text("Giriş Yap",style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: oxford,
                        fontSize: 16,
                      ),),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),
                // login button and social login


                SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: signUp,
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