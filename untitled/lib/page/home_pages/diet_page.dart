
import 'dart:math';

import 'package:untitled/model/Food/food_track_task.dart';
import 'package:untitled/page/home_pages/calorie-stats.dart';
import 'package:untitled/page/home_pages/meal_detail_page.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/constants.dart';

import 'package:untitled/model/Meal/meal.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  String title = 'Yemek Ekle';
  double servingSize = 0;
  String dropdownValue = 'grams';
  DateTime today = DateTime.now();
  Color _rightArrowColor = white;
  final Color _leftArrowColor = white;
  DateTime _value = DateTime.now();
  final _addFoodKey = GlobalKey<FormState>();

  DatabaseService databaseService =
   DatabaseService(uid: DATABASE_UID, currentDate: DateTime.now());

  late FoodTrackTask addFoodTrack;

  @override
  void initState() {
    super.initState();
    addFoodTrack = FoodTrackTask(
        food_name: "",
        calories: 0,
        carbs: 0,
        protein: 0,
        fat: 0,
        mealTime: "",
        createdOn: _value,
       );
    databaseService.getFoodTrackData(DATABASE_UID);
  }
  void resetFoodTrack() {
    addFoodTrack = FoodTrackTask(
      food_name: "",
      calories: 0,
      carbs: 0,
      protein: 0,
      fat: 0,
      mealTime: "",
      createdOn: _value,
    );
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _value,
      firstDate:  DateTime(2019),
      lastDate:  DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff5FA55A), //Head background
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _value = picked);
    _stateSetter();
  }

  void _stateSetter() {
    if (today.difference(_value).compareTo(const Duration(days: 1)) == -1) {
      setState(() => _rightArrowColor = const Color(0xffffffff));
    } else {
      setState(() => _rightArrowColor = Colors.white);
    }
  }


  checkFormValid() {
    if (addFoodTrack.calories != 0 &&
        addFoodTrack.carbs != 0 &&
        addFoodTrack.protein != 0 &&
        addFoodTrack.fat != 0
    ) {
      return true;
    }
    return false;
  }
  _showFoodToAdd(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: oxford,
            title: Text(title,style: GoogleFonts.roboto(
              color: white
            ),),
            content: _showAmountHad(),
            key: Key("add_food_modal"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context), // passing false
                child: Text('İptal',style: GoogleFonts.roboto(
                  color: Colors.white,
                ),),
              ),
              TextButton(
                onPressed: () async {
                  if (checkFormValid()) {
                    Navigator.pop(context);
                    var random =  Random();
                    int randomMilliSecond = random.nextInt(1000);
                    addFoodTrack.createdOn = _value;
                    addFoodTrack.createdOn = addFoodTrack.createdOn
                        .add(Duration(milliseconds: randomMilliSecond));
                    databaseService.addFoodTrackEntry(addFoodTrack);
                    resetFoodTrack();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Lütfen Zorunlu alanların hepsini giriniz.",style:GoogleFonts.roboto(

                      )),
                      backgroundColor: Colors.white,
                    ));
                  }
                },
                child: Text('Tamam',style: GoogleFonts.roboto(
                  color: Colors.white,
                ), key: Key("add_food_modal_submit")),
              ),
            ],
          );
        });
  }

  Widget _calorieCounter() {
    return  Container(
      decoration: BoxDecoration(
        color: back,
      ),
      height: 150,
      child: Row(
        children: <Widget>[
          CalorieStats(datePicked: _value),
        ],
      ),
    );

  }

  Widget _showAmountHad() {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _showAddFoodForm(),
        ]),
      ),
    );
  }

  Widget _showAddFoodForm() {
    return Form(
      key: _addFoodKey,
      child: Column(children: [
        TextFormField(
          key: Key('add_food_modal_food_name_field'),
          decoration: const InputDecoration(
            labelText: "Yemek Adı *",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Lütfen Yemek Adı Girin";
            }
            return null;
          },
          onChanged: (value) {
            addFoodTrack.food_name = value;
            // addFood.calories = value;
          },
        ),
        TextFormField(
          key: Key('add_food_modal_calorie_field'),
          decoration: const InputDecoration(
            labelText: "Kalori *",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Lütfem Kalori Miktarı Girin";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.calories = int.parse(value);
            } catch (e) {
              // return "Please enter numeric values"
              addFoodTrack.calories = 0;
            }

            // addFood.calories = value;
          },
        ),
        TextFormField(
          key: Key('add_food_modal_carbs_field'),
          decoration: const InputDecoration(
            labelText: "Karbonhidrat *",),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Lütfen Karbonhidrat Miktarı Girin";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.carbs = int.parse(value);
            } catch (e) {
              addFoodTrack.carbs = 0;
            }
          },
        ),
        TextFormField(
          key: Key('add_food_modal_protein_field'),
          decoration: const InputDecoration(
            labelText: "Protein *",

          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Lütfen Protein Miktarı Girin";
            }
            return null;
          },
          onChanged: (value) {
            try {
              addFoodTrack.protein = int.parse(value);
            } catch (e) {
              addFoodTrack.protein = 0;
            }
          },
        ),
        TextFormField(
          key: Key('add_food_modal_fat_field'),
          decoration: const InputDecoration(
            labelText: "Yağ *",),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Lütfem Yağ Miktarı Girin";
            }
            return null;
          },
          onChanged: (value) {
            try {
              addFoodTrack.fat = int.parse(value);
            } catch (e) {
              addFoodTrack.fat = 0;
            }
          },
        ),
      ]),
    );
  }


  Widget _showDatePicker() {
    return Container(
      width: 250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            key: Key("left_arrow_button"),
            icon: Icon(Icons.arrow_left, size: 25.0),
            color: _leftArrowColor,
            onPressed: () {
              setState(() {
                _value = _value.subtract(Duration(days: 1));
                _rightArrowColor = Colors.white;
              });
            },
          ),
          TextButton(
            // textColor: Colors.white,
            onPressed: () => _selectDate(),
            // },
            child: Text(_dateFormatter(_value),
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          IconButton(
              key: Key("right_arrow_button"),
              icon: Icon(Icons.arrow_right, size: 25.0),
              color: _rightArrowColor,
              onPressed: () {
                if (today.difference(_value).compareTo(Duration(days: 1)) ==
                    -1) {
                  setState(() {
                    _rightArrowColor = white;
                  });
                } else {
                  setState(() {
                    _value = _value.add(Duration(days: 1));
                  });
                  if (today.difference(_value).compareTo(Duration(days: 1)) ==
                      -1) {
                    setState(() {
                      _rightArrowColor = white;
                    });
                  }
                }
              }),
        ],
      ),
    );
  }
  String _dateFormatter(DateTime tm) {
    DateTime today =  DateTime.now();
    Duration oneDay =  Duration(days: 1);
    Duration twoDay =  Duration(days: 2);
    String month;

    switch (tm.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
      default:
        month = "Undefined";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "Bugün";
    } else if (difference.compareTo(twoDay) < 1) {
      return "Dün";
    } else {
      return "${tm.day} $month ${tm.year}";
    }
  }




  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14213D),

       bottom:PreferredSize(
         preferredSize:  const Size.fromHeight(5.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             _showDatePicker(),
             const Padding(
               padding:  EdgeInsets.only(right:10.0),
               child:  Icon(Icons.fitness_center,color:white),
             ),

           ],
         ),
       )

      ),

      body:  StreamProvider<List<FoodTrackTask>>.value(

          initialData: [],
        value: DatabaseService(
          uid:"untitled2-c9c9e",currentDate:DateTime.now()
        ).foodTracks,
      child:       SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _calorieCounter(),

            const SizedBox(height: 40,),


            const Padding(
              padding: EdgeInsets.only(left:15.0),
              child: Text("KAHVALTI",style: TextStyle(
                  color:Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700 )),
            ),

            const SizedBox(height: 10,),

            Row(
              children: <Widget> [
                const SizedBox(width: 15,),

                const Icon(Icons.add_circle_rounded,color: oxford),

                const SizedBox(width: 15,),

                GestureDetector(
                  onTap: () async{
                    setState(() {
                      _showFoodToAdd(context);
                    });

                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 45,
                    width: 290,
                    decoration: BoxDecoration(
                      color: oxford,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(" Y e m e k  E k l e ",style: GoogleFonts.roboto(
                            color:white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            const Padding(
              padding: EdgeInsets.only(left:15.0),
              child: Text("ARA ÖĞÜN",style: TextStyle(
                  color:Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700 )),
            ),

            const SizedBox(height: 10,),

            Row(
              children: <Widget> [
                const SizedBox(width: 15,),

                const Icon(Icons.add_circle_rounded,color: oxford,),

                const SizedBox(width: 15,),

                GestureDetector(
                  onTap: () async{
                    setState(() {
                      _showFoodToAdd(context);
                    });

                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),

                    height: 45,
                    width: 290,
                    decoration: BoxDecoration(
                      color: web,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [

                        Text(" Y e m e k  E k l e ",style: GoogleFonts.roboto(
                          color:white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            const Padding(
              padding: EdgeInsets.only(left:15.0),
              child: Text("ÖĞLE YEMEĞİ",style: TextStyle(
                  color:Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700 )),
            ),

            const SizedBox(height: 10,),

            Row(
              children: <Widget> [
                const SizedBox(width: 15,),

                const Icon(Icons.add_circle_rounded,color: oxford,),

                const SizedBox(width: 15,),

                GestureDetector(
                  onTap: () async{
                    setState(() {
                      _showFoodToAdd(context);
                    });

                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 45,
                    width: 290,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [

                        Text(" Y e m e k  E k l e ",style: GoogleFonts.roboto(
                          color:white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            const Padding(
              padding: EdgeInsets.only(left:15.0),
              child: Text("AKŞAM YEMEĞİ",style: TextStyle(
                  color:Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700 )),
            ),

            const SizedBox(height: 10,),

            Row(
              children: <Widget> [
                const SizedBox(width: 15,),

                const Icon(Icons.add_circle_rounded,color: oxford,),

                const SizedBox(width: 15,),

                GestureDetector(
                  onTap: () async{
                    setState(() {
                      _showFoodToAdd(context);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 45,
                    width: 290,
                    decoration: BoxDecoration(
                      color: fifth,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(" Y e m e k  E k l e ",style: GoogleFonts.roboto(
                          color:white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height:20 ,),


            SizedBox(
              height: height*0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,left: 16,right: 16),
                    child: Text("GÜNÜN YEMEKLERİ",style: GoogleFonts.roboto(
                        color:Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w700 )),
                  ),

                  // const SizedBox(height: 20,),

                  Expanded(
                    child:SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 25,),

                          for(int i=0;i<meals.length;i++) MealCard( meal: meals[i],),

                        ],
                      ) ,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 5,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: OpenContainer(
                closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                transitionDuration: const Duration(milliseconds: 1000),
                openBuilder: (context, _) {
                  return MealDetail(
                    meal: meal,
                  );
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: openContainer,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        meal.imagePath,
                        width: 130,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${meal.kiloCaloriesBurnt} kcal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.black12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${meal.timeTaken} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FoodTrackList extends StatelessWidget {
  final DateTime datePicked;
  late List<dynamic> curFoodTracks;
  late DatabaseService databaseService;
  FoodTrackList({super.key, required this.datePicked});

  @override
  Widget build(BuildContext context) {
    final DateTime curDate =
    DateTime(datePicked.year, datePicked.month, datePicked.day);

    final foodTracks = Provider.of<List<FoodTrackTask>>(context);

    List findCurFoodTracks(List foodTrackFeed) {
      List curFoodTracks = [];
      foodTrackFeed.forEach((foodTrack) {
        DateTime createdDate = DateTime(foodTrack.createdOn.year,
            foodTrack.createdOn.month, foodTrack.createdOn.day);
        if (createdDate.compareTo(curDate) == 0) {
          curFoodTracks.add(foodTrack);
        }
      });
      return curFoodTracks;
    }

    curFoodTracks = findCurFoodTracks(foodTracks);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: curFoodTracks.length + 1,
      itemBuilder: (context, index) {
        if (index < curFoodTracks.length) {
          return FoodTrackTile(
              foodTrackEntry: curFoodTracks[index], keyValue: index);
        } else {
          return SizedBox(height: 5);
        }
      },
    );
  }

  Future<void> loadFromMockDatabase() async {
    databaseService =  DatabaseService(
        uid: "untitled2-c9c9e", currentDate: DateTime.now());
    curFoodTracks.add(await databaseService.loadFoodTrackEntryToDatabase());
  }
}

class FoodTrackTile extends StatelessWidget {
  final FoodTrackTask foodTrackEntry;
  DatabaseService databaseService =  DatabaseService(
      uid: "untitled2-c9c9e", currentDate: DateTime.now());
  int keyValue;

  FoodTrackTile({required this.foodTrackEntry, required this.keyValue});

  List macros = CalorieStats.macroData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: Key("food_track_tile_$keyValue"),
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: oxford,
        child: _itemCalories(),
      ),
      title: Text(foodTrackEntry.food_name,
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          )),
      subtitle: _macroData(),
    );
  }

  Widget _itemCalories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(foodTrackEntry.calories.toStringAsFixed(0),
            style: GoogleFonts.roboto(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
        Text('kcal',
            style: GoogleFonts.roboto(
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }

  Widget _macroData() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const  BoxDecoration(
                      color: oxford,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(' ${foodTrackEntry.carbs.toStringAsFixed(1)}g    ',
                      style: GoogleFonts.roboto(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                      ' ${foodTrackEntry.protein.toStringAsFixed(1)}g    ',
                      style: GoogleFonts.roboto(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: web,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(' ${foodTrackEntry.fat.toStringAsFixed(1)}g',
                      style: GoogleFonts.roboto(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

}