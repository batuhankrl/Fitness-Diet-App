import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/model/User/UserData.dart';
import 'package:flutter/cupertino.dart';

class Calculate{


  double bmi=0.0,calorie_activity=0.0,calorie_goal=0.0,bmr=0.0;

  Calculate({Key? key });

  final user=FirebaseAuth.instance.currentUser!;


  String calculateBMI(UserData user){
    bmi=user.weight/pow(user.height/100,2);
    return bmi.toStringAsFixed(2);
  }

  String getWeight(UserData user){
    return user.weight.toString();
  }
  String getHeight(UserData user){
    return user.height.toString();
  }
  String calculateBMR(UserData user){
    if(user.gender=='Kadın' ) {
      bmr=(10 * user.weight + 6.25 * user.height * 2.54 - 5 * user.age - 161)-166;

    } else {
      bmr = (10 * user.weight + 6.25 * user.height - 5 * user.age + 5)+166;
    }
    return bmr.toStringAsFixed(2);
    // return height.toString();
  }

  String getCalori(UserData user){

    if(user.goal==0){
      switch (user.activity) {
        case 0:
          {
            calorie_activity=bmr*1.2-500;
          }
          break;
        case 1:
          {
            calorie_activity=bmr*1.375-500;
          }
          break;
        case 2:
          {
            calorie_activity=bmr*1.55-500;
          }
          break;
        case 3:
          {
            calorie_activity=bmr*1.725-500;
          }
          break;
      }
      return calorie_activity.toStringAsFixed(2);
    }
else if(user.goal==1){
  switch (user.activity) {
    case 0:
      {
        calorie_activity=bmr*1.2;
      }
      break;
    case 1:
      {
        calorie_activity=bmr*1.375;
      }
      break;
    case 2:
      {
        calorie_activity=bmr*1.55;
      }
      break;
    case 3:
      {
        calorie_activity=bmr*1.725;
      }
      break;
  }
  return calorie_activity.toStringAsFixed(2);
}
else if(user.goal==2){
  switch (user.activity) {
    case 0:
      {
        calorie_activity=bmr*1.2+500;
      }
      break;
    case 1:
      {
        calorie_activity=bmr*1.375+500;
      }
      break;
    case 2:
      {
        calorie_activity=bmr*1.55+500;
      }
      break;
    case 3:
      {
        calorie_activity=bmr*1.725+500;
      }
      break;
  }
  return calorie_activity.toStringAsFixed(2);

}
else {
           return "0";
    }

  }
  String getGoal(UserData user){

    switch (user.goal) {
      case 0:
        {
          calorie_goal=calorie_activity-500;
        }
        break;
      case 1:
        {
          calorie_goal=calorie_activity;
        }
        break;
      case 2:
        {
          calorie_goal=calorie_activity+500;
        }
        break;
    }
    return calorie_goal.toStringAsFixed(2);
  }

  String getInterpretation(){
    if(bmi>=25) {
      return "You have a higher than normal body weight. Try to exercise more.";
    } else if(bmi>18.5) {
      return "You have normal body weight. Good Job!!";
    } else {
      return "You have a lower than normal body weight. You can eat a bit more.";
    }
  }


  Future<UserData?> readUsers() async{
    final docUser=FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot=await docUser.get();

    if(snapshot.exists){
      return UserData.fromJson(snapshot.data()!);
    }



  }
}