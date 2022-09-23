
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled/model/Food/food_track_task.dart';
import 'package:untitled/theme/colors.dart';
import 'package:untitled/utils/theme_colors.dart';




class CalorieStats extends StatelessWidget {
  DateTime datePicked;
  DateTime today = DateTime.now();
  CalorieStats({required this.datePicked});

  num totalCalories = 0;
  num totalCarbs = 0;
  num totalFat = 0;
  num totalProtein = 0;
  num displayCalories = 0;


  static List<num> macroData = [];



  bool dateCheck() {
    DateTime formatPicked =
    DateTime(datePicked.year, datePicked.month, datePicked.day);
    DateTime formatToday = DateTime(today.year, today.month, today.day);
    if (formatPicked.compareTo(formatToday) == 0) {
      return true;
    } else {
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {

    final DateTime curDate =
    new DateTime(datePicked.year, datePicked.month, datePicked.day);

    final foodTracks = Provider.of<List<FoodTrackTask>>(context);

    List findCurFoodTracks(List<FoodTrackTask> foodTracks) {
      List currentFoodTracks = [];
      foodTracks.forEach((foodTrack) {
        DateTime trackDate = DateTime(foodTrack.createdOn.year,
            foodTrack.createdOn.month, foodTrack.createdOn.day);
        if (trackDate.compareTo(curDate) == 0) {
          currentFoodTracks.add(foodTrack);
        }
      });
      return currentFoodTracks;
    }
    // ignore: deprecated_member_use
    List<PieChartSectionData> _sections = <PieChartSectionData>[];

    PieChartSectionData _fat = PieChartSectionData(
      color: primary,
      value: (9 * (totalFat) / totalCalories) * 100,
      title:
      '', // ((9 * totalFat / totalCalories) * 100).toStringAsFixed(0) + '%',
      radius: 5,
      // titleStyle: TextStyle(color: Colors.white, fontSize: 24),
    );

    PieChartSectionData _carbohydrates = PieChartSectionData(
      color: oxford,
      value: (4 * (totalCarbs) / totalCalories) * 100,
      title:
      '', // ((4 * totalCarbs / totalCalories) * 100).toStringAsFixed(0) + '%',
      radius: 5,
      // titleStyle: TextStyle(color: Colors.black, fontSize: 24),
    );

    PieChartSectionData _protein = PieChartSectionData(
      color: web,
      value: (4 * (totalProtein) / totalCalories) * 100,
      title:
      '', // ((4 * totalProtein / totalCalories) * 100).toStringAsFixed(0) + '%',
      radius: 5,
      // titleStyle: TextStyle(color: Colors.white, fontSize: 24),
    );

    _sections = [_fat, _protein, _carbohydrates];

    macroData = [displayCalories, totalProtein, totalCarbs, totalFat];

    totalCarbs = 0;
    totalFat = 0;
    totalProtein = 0;
    displayCalories = 0;

    Widget _chartLabels() {
      return Padding(
        padding: EdgeInsets.only(top: 50.0,left: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Karbonhidrat ',
                    style: GoogleFonts.roboto(
                      color: oxford,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
                Text('${macroData[2].toStringAsFixed(1)}g',
                    style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            SizedBox(height: 3.0),
            Row(
              children: <Widget>[
                Text('Protein ',
                    style: GoogleFonts.roboto(
                      color: web,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
                Text('${macroData[1].toStringAsFixed(1)}g',
                    style: GoogleFonts.roboto(
                      color: web,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
            SizedBox(height: 3.0),
            Row(
              children: <Widget>[
                Text('Yağ ',
                    style: GoogleFonts.roboto(
                      color: primary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
                Text('${macroData[3].toStringAsFixed(1)}g',
                    style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 0, 0, 0),

                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          ],
        ),
      );
    }

    Widget _calorieDisplay() {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xffffff),
          shape: BoxShape.circle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(macroData[0].toStringAsFixed(0),
                style: GoogleFonts.roboto(
                  fontSize: 24.0,
                  letterSpacing: 0.6,
                  color: oxford,
                  fontWeight: FontWeight.w500,
                )),
            Text('kcal',
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  letterSpacing: 0.6,
                  color: oxford,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      );
    }
      return Container(
        child: Row(
          children: <Widget>[
            Stack(alignment: Alignment.center, children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sections: _sections,
                    borderData: FlBorderData(show: false),
                    centerSpaceRadius: 50,
                    sectionsSpace: 3,
                  ),
                ),
              ),
              _calorieDisplay(),
            ]),
            _chartLabels(),
          ],
        ),
      );

  }
}
