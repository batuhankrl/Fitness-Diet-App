
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/page/inputPages/gender_input.dart';
import 'package:untitled/page/root_app.dart';
import 'package:untitled/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/page/auth/main_page.dart';
import 'package:flutter/src/widgets/framework.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'CHAINGE';

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primaryColor: const Color(0xFF14213D),
      ),
      home: const MainPage(),

    );

  }
}