import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflectly_clone/notifiers/theme_notifier.dart';
import 'package:reflectly_clone/utils/theme.dart';
const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 100.0;

class ThemeChangeScreen extends StatefulWidget {
  @override
  _ThemeChangeScreenState createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  double viewPortFraction = 0.5;

  PageController pageController;

  int currentPage = 2;

  List<Map<String, String>> listOfCharacters = [
    {'image': "assets/richmond.png", 'name': "Richmond"},
    {'image': "assets/roy.png",'name': "Roy"},
    {'image': "assets/moss.png", 'name': "Moss"},
    {'image': "assets/douglas.png", 'name': "Douglas"},
    {'image': "assets/jen.png", 'name': "Jen"}
  ];

  double page = 1.0;

  @override
  void initState() {
    pageController =
        PageController(initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(

      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Text('Choose your mood',style: TextStyle(fontSize: 30),),
          SizedBox(height: 20,),
          Container(
            height: PAGER_HEIGHT,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    page = pageController.page;
                  });
                }
                return true;
              },
              child: PageView.builder(

                onPageChanged: (index) {
                  themeNotifier.setTheme(appThemesList[index].themeData);
                  setState(() {
                    currentPage = index;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: appThemesList.length,
                itemBuilder: (context, index) {
                  final scale =
                  max(SCALE_FRACTION, (FULL_SCALE - (index - page).abs()) + viewPortFraction);

                  return circleOffer(
                      listOfCharacters[index]['image'], scale,index);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              appThemesList[currentPage].themeName,
              textAlign: TextAlign.center,
//              style: TextStyle(fontSize: 20),
            ),
          ),

        ],
      ),
    );
  }

  Widget circleOffer(String image, double scale, int index) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
//        duration: Duration(milliseconds: 200),
//        curve: Curves.easeIn,
        margin: EdgeInsets.only(bottom: 10),
        height: PAGER_HEIGHT * scale,
        width: PAGER_HEIGHT * scale,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          color: appThemesList[index].themeData.primaryColor,
          shape: CircleBorder(side: BorderSide(color: Colors.grey.shade200, width: 5)),

        ),
      ),
    );
  }
}