import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/all/all.dart';
import 'package:wrtproject/screen/bookmark/bookmark.dart';
import 'package:wrtproject/screen/Home/dash.dart';
import 'package:wrtproject/screen/genrepage/genre_list.dart';
import 'package:wrtproject/screen/setting/setting.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

  FirebaseAuth auth = FirebaseAuth.instance;

  dynamic legt2;
  dynamic cekupdate;
  bool load = false;
  CollectionReference data = FirebaseFirestore.instance.collection("Server");
  cek() async {
    await data
        .doc("Server")
        .get()
        .then<dynamic>((DocumentSnapshot value) async {
      legt2 = value.data();
    });
    await data
        .doc("Update")
        .get()
        .then<dynamic>((DocumentSnapshot value) async {
      cekupdate = value.data();
    });
    setState(() {
      load = true;
    });
  }

  @override
  void initState() {
    super.initState();
    cek();
  }

  final List<Widget> tab = [Dash(), Semua(), Genlist(), Bookmark(), Setting()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: (load)
          ? (legt2['status'] == 1)
              ? (cekupdate['version'] == Const.version)
                  ? tab[navIndex]
                  : updateMode(cekupdate['version'], cekupdate['Message'],
                      cekupdate['Link'])
              : maintenanceMode("Mohon Maaf Server WRT Sedang Maintenance")
          : maintenanceMode("Loading..."),
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

  maintenanceMode(String message) {
    return Container(
        color: Const.bgcolor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message,
                  style: GoogleFonts.chakraPetch(
                      textStyle: TextStyle(fontSize: 20))),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: Colors.deepPurple,
                strokeWidth: 2,
              )
            ],
          ),
        ));
  }
}

updateMode(String title, message, link) {
  return Container(
      color: Const.bgcolor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("New Update Versi " + title,
                style: GoogleFonts.chakraPetch(
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 250,
              child: Text(message,
                  style:
                      GoogleFonts.roboto(textStyle: TextStyle(fontSize: 18))),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  launch(link);
                },
                icon: Icon(Icons.update),
                label: Text("Update Sekarang"))
          ],
        ),
      ));
}
