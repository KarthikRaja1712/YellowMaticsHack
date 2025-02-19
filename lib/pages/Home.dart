import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:ymhackathon/pages/ChatScreen.dart';
import 'package:ymhackathon/pages/SecondPage.dart';
import 'package:ymhackathon/widgets/CardWidget.dart';

class Home extends StatefulWidget {
  final Function()? onMenuTap;
  const Home({Key? key, this.onMenuTap}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tabNo = 0;
  late bool overlayVisible;
  CupertinoTabController? controller;

  @override
  void initState() {
    overlayVisible = false;
    controller = CupertinoTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CupertinoTabScaffold(
          backgroundColor: material.Colors.white,
          controller: controller,
          tabBar: CupertinoTabBar(
            onTap: (value) {
              setState(() {
                tabNo = value;
              });
            },
            activeColor: material.Colors.green,
            inactiveColor: material.Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house_fill), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_2_fill), label: "Assistant"),
              BottomNavigationBarItem(icon: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_circle_fill), label: "Videos"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chart_bar_alt_fill),
                  label: "Leaderboard"),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return HomePage(onMenuTap: widget.onMenuTap);
              case 1:
                return ChatScreen();
              case 3:
                return SecondPage();
              case 4:
                return Container(color: material.Colors.orange.shade50);
              default:
                return Container();
            }
          },
        ),
        Positioned(
          bottom: 20,
          child: material.FloatingActionButton(
            elevation: 10,
            backgroundColor: material.Colors.green,
            child: overlayVisible
                ? Icon(material.Icons.games_outlined,
                    color: material.Colors.white)
                : Icon(material.Icons.gamepad, color: material.Colors.white),
            onPressed: () {
              setState(() {
                overlayVisible = !overlayVisible;
                //  if (!overlayVisible) {
                Navigator.push(
                  context,
                  material.MaterialPageRoute(
                      builder: (context) => SecondPage()),
                );
                // }
              });
            },
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  final Function()? onMenuTap;
  const HomePage({Key? key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      backgroundColor: material.Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.bars,
                      color: material.Colors.green, size: screenWidth * 0.07),
                  Text(
                    "Financial Learning",
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: material.Colors.black),
                  ),
                  Icon(CupertinoIcons.bell,
                      color: material.Colors.green, size: screenWidth * 0.07),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                children: [
                  Text(
                    "Recommended Courses",
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  VideoCard(
                    thumbnail: 'assets/INTROpic.jpg',
                    title: 'Introduction to world of money',
                    channelName: 'Finance',
                    views: '15',
                    duration: '5mins',
                  ),
                  VideoCard(
                    thumbnail: 'assets/INTROpic.jpg',
                    title: 'Introduction to world of money',
                    channelName: 'Finance',
                    views: '15',
                    duration: '5mins',
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Recent Lessons",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
