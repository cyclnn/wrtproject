import 'package:flutter/material.dart';
import 'package:wrtproject/screen/Home/chatango.dart';
import 'package:wrtproject/screen/Home/donasi.dart';
import 'package:wrtproject/screen/Home/komikcard/populer_card.dart';
import 'package:wrtproject/screen/Home/komikcard/update_card.dart';
import 'package:wrtproject/screen/search/search.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import '../../mesin/const.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  bool komikLoad = false;
  var udah = List(30);
  List<Map<String, dynamic>> komiklist;
  List<Map<String, dynamic>> hotlist;
  List<Map<String, dynamic>> namalist;
  List<Map<String, dynamic>> chlist;
  List<Map<String, dynamic>> hotnama;
  List<Map<String, dynamic>> hotch;
  List<Map<String, dynamic>> rating;
  List<Map<String, dynamic>> link;
  List<Map<String, dynamic>> linkup;
  int history;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('history$history') == null) {
      for (var i = 0; i < 30; i++) {
        udah[i] = "false";
      }
      history = 0;
      prefs.setInt('history$history', history);
    } else if (prefs.getInt('history$history') == 10) {
      for (var i = 0; i < 30; i++) {
        udah[i] = "false";
      }
      history = 0;
      prefs.setInt('history$history', history);
    } else {
      return 0;
    }
  }

  void fetchKomik() async {
    final webscraper = WebScraper("https://wrt.my.id/");
    if (await webscraper.loadWebPage('')) {
      komiklist = webscraper.getElement(
          'div.bixbox > div.listupd > div.utao > div.uta > div.imgu > a > img',
          ['src']);

      hotlist = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.limit > img", ['src']);
      hotch = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.bigor > div.adds > div.epxs",
          []);
      hotnama = webscraper
          .getElement("div.listupd > div.bs > div.bsx > a ", ['title']);

      namalist = webscraper.getElement(
          'div.bixbox > div.listupd > div.utao > div.uta > div.imgu > a',
          ['title']);
      chlist = webscraper.getElement(
          'div.bixbox > div.listupd > div.utao > div.uta > div.luf > a > h4',
          ['title']);
      rating = webscraper.getElement(
          'div.listupd > div.bs > div.bsx > a > div.bigor > div.adds > div.rt > div.rating  > div.numscore',
          []);
      link =
          webscraper.getElement('div.listupd > div.bs > div.bsx > a', ['href']);
      linkup = webscraper.getElement(
          'div.bixbox >  div.listupd > div.utao > div.uta > div.luf > a',
          ['href']);

      setState(() {
        komikLoad = true;
      });
    }
  }

  var ads, ads2;

  cekAds() async {
    SharedPreferences ad = await SharedPreferences.getInstance();
    ads = ad.getInt("Ads1");
    ads2 = ad.getInt("Ads2");
  }



  @override
  void initState() {
    addStringToSF();
    super.initState();
    fetchKomik();
    cekAds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Const.baseColor);
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Const.baseColor,
          title: Image.asset(
            "assets/img/lg2.png",
            height: 50,
          ),
          toolbarHeight: 70,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Get.to(() => (Chatango()), transition: Transition.downToUp);
                });
              },
              iconSize: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.sync,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  fetchKomik();
                });
              },
              iconSize: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(() => Search(), transition: Transition.downToUp);
              },
              iconSize: 20,
            )
          ],
        ),
        body: komikLoad
            ? Container(
                decoration: BoxDecoration(color: Const.bgcolor),
                height: screensize.height,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      
                      donasi(),
                      populerCard(
                          hotlist, hotnama, hotch, rating, link, ads, ads2),
                      SizedBox(
                        height: 10,
                      ),
                      updateCard(komiklist, namalist, chlist, linkup,
                          "UPDATE WRT", 0, 15, ads, ads2),
                      SizedBox(
                        height: 10,
                      ),
                      updateCard(komiklist, namalist, chlist, linkup,
                          "UPDATE TERBARU", 15, 39, ads, ads2),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            : Container(
                color: Const.cardcolor,
                width: double.infinity,
                height: screensize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/lg3.png",
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                      strokeWidth: 2,
                    )),
                  ],
                ),
              ));
  }
}

class Bookm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text("habib"),
      ),
    );
  }
}
