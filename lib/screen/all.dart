import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrtproject/screen/all/recent.dart';
import 'package:wrtproject/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrtproject/screen/pj.dart';
import 'package:wrtproject/screen/semua.dart';

class Semua extends StatefulWidget {
  @override
  _SemuaState createState() => _SemuaState();
}

class _SemuaState extends State<Semua> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Color.fromRGBO(228, 68, 238, 1),
        bottom: TabBar(
          controller: controller,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.blue,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.history,
                size: 20,
              ),
              child: Text(
                "History",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.list,
                size: 20,
              ),
              child: Text(
                "Semua",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.book,
                size: 20,
              ),
              child: Text(
                "Project",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Recent(controller),
          AllKom(controller, 1),
          AllPj(controller),
        ],
      ),
    );
  }
}
