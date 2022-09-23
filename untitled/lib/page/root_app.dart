import 'package:untitled/page/home_pages/diet_page.dart';
import 'package:untitled/page/home_pages/history_page.dart';
import 'package:untitled/page/home_pages/home_page.dart';
import 'package:untitled/page/home_pages/user_profile_page.dart';
import 'package:untitled/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        HomePage(),
        DietPage(),
        HistoryScreen(),
        ProfilPage(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      LineIcons.home,
      LineIcons.fire,
      LineIcons.lineChart,
      LineIcons.user
    ];
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        border:
        Border(top: BorderSide(width: 1, color: black.withOpacity(0.06))),
      ),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return InkWell(
              onTap: (){
                setState(() {
                  pageIndex = index;
                });
              },
              child: Column(
                children: [
                  Icon(items[index],size: 25,color: pageIndex == index ? sixth: web,),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}