import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wrtproject/screen/all.dart';
import 'package:wrtproject/screen/bookmark.dart';
import 'package:wrtproject/screen/dash.dart';
import 'package:wrtproject/screen/genre_list.dart';
import 'package:wrtproject/screen/setting.dart';

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
          backgroundColor: Color.fromRGBO(228, 68, 238, 1),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          currentIndex: navIndex,
          onTap: selectNavBot,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'All'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Genres'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'Bookmark'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          ],
        ),
      ),
    );
  }
}
