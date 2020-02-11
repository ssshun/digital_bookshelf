import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_book_shelf/ranking.dart';
import 'package:digital_book_shelf/search.dart';
import 'package:digital_book_shelf/setting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages = [
    Ranking(),
    Search(),
    Setting(),
  ];
  final iconSize = 28.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('ランキング'),
            icon: Icon(FontAwesomeIcons.star, size: iconSize),
          ),
          BottomNavigationBarItem(
            title: Text('検索'),
            icon: Icon(FontAwesomeIcons.search, size: iconSize),
          ),
          BottomNavigationBarItem(
            title: Text('設定'),
            icon: Icon(FontAwesomeIcons.user, size: iconSize),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      tabBuilder: (BuildContext context, int index) {
        return new CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              child: _pages[index],
            );
          },
        );
      },
    );
  }
}
