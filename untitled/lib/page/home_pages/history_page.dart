import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/charts/datetime_series_chart.dart';


class HistoryScreen extends StatefulWidget {

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int pageIndex = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isBack = true;
  @override
  void initState() {
    super.initState();
  }
  void onClickBackButton() {
    print("Back Button");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor: const Color(0xFF14213D),
        title:Text("C  H  A  I  N  G  E",style:GoogleFonts.bebasNeue(
          fontSize: 25,
          letterSpacing: 0.2,

        )),
        centerTitle: true,
        actions: const [
          Icon( Icons.fitness_center, ),
          SizedBox(width:12),
        ],
      ),

      body: Container(
        child: DateTimeChart(),
    ));

  }
}
