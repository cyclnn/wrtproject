import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/all/all.dart';
import 'package:wrtproject/screen/bookmark/bookmark.dart';
import 'package:wrtproject/screen/Home/dash.dart';
import 'package:wrtproject/screen/genrepage/genre_list.dart';
import 'package:wrtproject/screen/setting/setting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navIndex = 0;

  void selectNavBot(int index) {
    setState(() {
      navIndex = index;
    });
  }

  final List<Widget> tab = [Dash(), Semua(), Genlist(), Bookmark(), Setting()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: tab[navIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Const.baseColor,
          unselectedItemColor: Const.unselected,
          selectedItemColor: Const.selected,
          currentIndex: navIndex,
          onTap: selectNavBot,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'All'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Genres'),
            BottomNavigationBarItem(
                icon: new Icon(MdiIcons.bookmarkCheck), label: 'Bookmark'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          ],
        ),
      ),
    );
  }
}
