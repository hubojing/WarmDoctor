import 'package:WarmDoctor/Pages/BookPage.dart';
import 'package:flutter/material.dart';
import 'package:WarmDoctor/config/Text.dart';
import 'package:WarmDoctor/pages/HomePage.dart';
import 'package:WarmDoctor/pages/ArticlePage.dart';
import 'package:WarmDoctor/pages/CommunicationPage.dart';

import 'package:WarmDoctor/widget/Bar/RootTabbar.dart';
import 'package:WarmDoctor/config/Color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_title,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    List<TabBarModel> pages = <TabBarModel>[
      new TabBarModel(
        title: '首页',
        icon: new LoadImage("assets/images/bottom_home.png", false),
        selectIcon: new LoadImage("assets/images/bottom_home.png", true),
        page: new HomePage(),
      ),
      new TabBarModel(
        title: '文章',
        icon: new LoadImage("assets/images/bottom_article.png", false),
        selectIcon: new LoadImage("assets/images/bottom_article.png", true),
        page: new ArticlePage(),
      ),
      new TabBarModel(
        title: '书籍',
        icon: new LoadImage("assets/images/bottom_book.png", false),
        selectIcon: new LoadImage("assets/images/bottom_book.png", true),
        page: new BookPage(),
      ),
      new TabBarModel(
        title: '交流',
        icon: new LoadImage("assets/images/bottom_communication.png", false),
        selectIcon: new LoadImage("assets/images/bottom_communication.png", true),
        page: new CommunicationPage(),
      ),
    ];
    return new RootTabBar(pages: pages, currentIndex: 0);
  }
}


class LoadImage extends StatelessWidget {
  final String img;
  final bool isSelect;

  LoadImage(this.img, [this.isSelect = false]);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 2.0),
      width: 30.0,
      height: 30.0,
      child: new Image.asset(
        img,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        color: isSelect ? fixedColor : mainTextColor,
      ),
    );
  }
}