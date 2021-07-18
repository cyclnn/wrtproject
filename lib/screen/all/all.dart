import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/all/recent.dart';
import 'package:wrtproject/screen/all/pj.dart';
import 'package:wrtproject/screen/all/semua.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Semua extends StatefulWidget {
  @override
  _SemuaState createState() => _SemuaState();
}

class _SemuaState extends State<Semua> with SingleTickerProviderStateMixin {
  TabController controller;
  var ads2, ads3;
  cekAds() async {
    SharedPreferences ad = await SharedPreferences.getInstance();
    ads2 = ad.getInt("Ads2");
    ads3 = ad.getInt("Ads3");
  }

  @override
  void initState() {
    super.initState();
    cekAds();
    controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Const.baseColor,
        bottom: TabBar(
          controller: controller,
          unselectedLabelColor: Const.unselected,
          indicatorColor: Const.selected,
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
          AllKom(controller, 1, ads3, ads2),
          AllPj(controller, ads3, ads2),
        ],
      ),
    );
  }
}
