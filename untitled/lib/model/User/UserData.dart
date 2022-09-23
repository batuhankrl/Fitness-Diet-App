import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String id;
  final String firstName;
  final String lastName;
  final String gender;
  final int age;
  final double height;
  final double weight;
  final int activity;
  final int goal;

  UserData({
    this.id='',
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activity,
    required this.goal,
  });
  Map<String,dynamic> toJson() =>{

    'id':id,
    'firstName':firstName,
    'lastName':lastName,
    'gender':gender,
    'age':age,
    'height':height,
    'weight':weight,
    'activity':activity,
    'goal':goal,

  };

  static UserData fromJson(Map<String,dynamic> json)=> UserData(

    id:json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    gender: json['gender'],
    age: json['age'],
    height: json['height'],
    weight: json['weight'],
    activity: json['activity'],
    goal: json['goal'],
  );

/*Stream<List<UserData>> readUsers() => FirebaseFirestore.instance
.collection('users').snapshots().map((snapshot)
 => snapshot.docs.map((doc) => UserData.fromJson(doc.data())).toList());*/

  Future<UserData?> readUsers() async{
    final docUser=FirebaseFirestore.instance.collection('users').doc(id);

    final snapshot=await docUser.get();

    if(snapshot.exists){
      return UserData.fromJson(snapshot.data()!);
    }



  }

}