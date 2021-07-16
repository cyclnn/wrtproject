import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/database.dart';
import 'package:wrtproject/mesin/history.dart';
import 'package:wrtproject/screen/Home/chatango.dart';
import 'package:wrtproject/screen/detailpage/detail.dart';
import 'package:wrtproject/screen/Home/populer.dart';
import 'package:wrtproject/screen/search/search.dart';
import 'package:wrtproject/screen/Home/update.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../mesin/const.dart';
import 'package:get/get.dart';

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

 

  @override
  void initState() {
    addStringToSF();
    super.initState();
    fetchKomik();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Const.baseColor);
    FirebaseAuth auth = FirebaseAuth.instance;

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
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          child: Image.asset(
                            "assets/img/tr.png",
                            width: double.infinity,
                            height: 90,
                          ),
                          onTap: () async {
                            await launch(
                                "https://trakteer.id/WorldRomanceTranslation");
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Const.cardcolor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 8),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'TERPOPULER HARI INI',
                                style: TextStyle(
                                    color: Const.text,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Const.text,
                            ),
                            Wrap(children: [
                              Container(
                                height: 230,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (var i = 0; i < 5; i++)
                                      GestureDetector(
                                        child: Populer(
                                            komikImg: hotlist[i]['attributes']
                                                ['src'],
                                            komikTitle: hotnama[i]['attributes']
                                                ['title'],
                                            chhot: hotch[i]['title']
                                                .toString()
                                                .trim(),
                                            star: rating[0]['title']
                                                .toString()
                                                .trim()),
                                        onTap: () async {
                                          if (udah[i] == "false") {
                                            udah[i] = "true";
                                            history++;
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setInt(
                                                'history$history', history);
                                            prefs.setInt('nilai', history);
                                            Get.to(
                                                () => Detail(
                                                      lnk: link[i]['attributes']
                                                          ['href'],
                                                      gambar: hotlist[i]
                                                          ['attributes']['src'],
                                                      nama: hotnama[i]
                                                              ['attributes']
                                                          ['title'],
                                                      urut: i,
                                                      id: prefs.getInt(
                                                          'history$history'),
                                                    ),
                                                transition:
                                                    Transition.downToUp);
                                          } else {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            prefs.setInt(
                                                'history$history', history);
                                            prefs.setInt('nilai', history);
                                            Get.to(
                                                () => Detail(
                                                      lnk: link[i]['attributes']
                                                          ['href'],
                                                      gambar: hotlist[i]
                                                          ['attributes']['src'],
                                                      nama: hotnama[i]
                                                              ['attributes']
                                                          ['title'],
                                                      urut: i,
                                                      id: 100,
                                                    ),
                                                transition:
                                                    Transition.downToUp);
                                          }
                                        },
                                      )
                                  ],
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Const.cardcolor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(top: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'UPDATE WRT',
                                style: TextStyle(
                                    color: Const.text,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Const.text,
                            ),
                            Center(
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                        BoxConstraints constraints) =>
                                    Wrap(
                                  children: [
                                    for (var i = 0; i < 15; i++)
                                      Column(
                                        children: [
                                          GestureDetector(
                                            child: (constraints.maxWidth >
                                                        300 &&
                                                    constraints.maxWidth < 500)
                                                ? UpdatePJ2(
                                                    komikImg: komiklist[i]
                                                        ['attributes']['src'],
                                                    komikTitle: namalist[i]
                                                        ['attributes']['title'],
                                                    ch: chlist[i]['attributes']
                                                        ['title'],
                                                  )
                                                : (constraints.maxWidth > 500 &&
                                                        constraints.maxWidth <
                                                            1000)
                                                    ? UpdatePJ(
                                                        komikImg: komiklist[i]
                                                                ['attributes']
                                                            ['src'],
                                                        komikTitle: namalist[i]
                                                                ['attributes']
                                                            ['title'],
                                                        ch: chlist[i]
                                                                ['attributes']
                                                            ['title'],
                                                      )
                                                    : UpdatePJ2(
                                                        komikImg: komiklist[i]
                                                                ['attributes']
                                                            ['src'],
                                                        komikTitle: namalist[i]
                                                                ['attributes']
                                                            ['title'],
                                                        ch: chlist[i]
                                                                ['attributes']
                                                            ['title'],
                                                      ),
                                            onTap: () {
                                              Get.to(
                                                  () => Detail(
                                                      lnk: linkup[i]
                                                              ['attributes']
                                                          ['href'],
                                                      gambar: komiklist[i]
                                                          ['attributes']['src'],
                                                      nama: namalist[i]
                                                              ['attributes']
                                                          ['title']),
                                                  transition:
                                                      Transition.downToUp);
                                            },
                                            onLongPress: () {},
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Const.cardcolor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(top: 8),
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'UPDATE TERBARU',
                                    style: TextStyle(
                                        color: Const.text,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  color: Const.text,
                                ),
                                (auth.currentUser == null)
                                    ? Center(
                                        child: Container(
                                          margin: EdgeInsets.all(100),
                                          height: 35,
                                          width: 200,
                                          color: Colors.red,
                                          child: Center(
                                            child: Text("Please Login"),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: FutureBuilder(
                                          future: Database.getData("jenis"),
                                          builder: (context, snapshot) {
                                            if (snapshot.data['akun'] != "1")
                                              return Center(
                                                child: Container(
                                                  margin: EdgeInsets.all(100),
                                                  height: 35,
                                                  width: 200,
                                                  color: Colors.red,
                                                  child: Center(
                                                    child: Text("Beta Test"),
                                                  ),
                                                ),
                                              );
                                            else
                                              return LayoutBuilder(
                                                builder: (BuildContext context,
                                                        BoxConstraints
                                                            constraints) =>
                                                    Wrap(
                                                  children: [
                                                    for (var i = 15;
                                                        i < 39;
                                                        i++)
                                                      GestureDetector(
                                                        child: (constraints
                                                                        .maxWidth >
                                                                    300 &&
                                                                constraints
                                                                        .maxWidth <
                                                                    500)
                                                            ? UpdatePJ2(
                                                                komikImg:
                                                                    komiklist[i]
                                                                            [
                                                                            'attributes']
                                                                        ['src'],
                                                                komikTitle: namalist[
                                                                            i][
                                                                        'attributes']
                                                                    ['title'],
                                                                ch: chlist[i][
                                                                        'attributes']
                                                                    ['title'],
                                                              )
                                                            : (constraints.maxWidth >
                                                                        500 &&
                                                                    constraints
                                                                            .maxWidth <
                                                                        1000)
                                                                ? UpdatePJ(
                                                                    komikImg: komiklist[i]
                                                                            [
                                                                            'attributes']
                                                                        ['src'],
                                                                    komikTitle: namalist[i]
                                                                            [
                                                                            'attributes']
                                                                        [
                                                                        'title'],
                                                                    ch: chlist[i]
                                                                            [
                                                                            'attributes']
                                                                        [
                                                                        'title'],
                                                                  )
                                                                : UpdatePJ2(
                                                                    komikImg: komiklist[i]
                                                                            [
                                                                            'attributes']
                                                                        ['src'],
                                                                    komikTitle: namalist[i]
                                                                            [
                                                                            'attributes']
                                                                        [
                                                                        'title'],
                                                                    ch: chlist[i]
                                                                            [
                                                                            'attributes']
                                                                        [
                                                                        'title'],
                                                                  ),
                                                        onTap: () {
                                                          Get.to(
                                                              () => Detail(
                                                                  lnk: linkup[i]
                                                                          ['attributes']
                                                                      ['href'],
                                                                  gambar: komiklist[i]
                                                                          ['attributes']
                                                                      ['src'],
                                                                  nama: namalist[
                                                                              i]
                                                                          ['attributes']
                                                                      [
                                                                      'title']),
                                                              transition:
                                                                  Transition
                                                                      .downToUp);
                                                          History.createOrupdate(
                                                              1,
                                                              nama: namalist[i][
                                                                      'attributes']
                                                                  ['title'],
                                                              img: komiklist[i][
                                                                      'attributes']
                                                                  ['src'],
                                                              link: linkup[i][
                                                                      'attributes']
                                                                  ['href']);
                                                        },
                                                      )
                                                  ],
                                                ),
                                              );
                                          },
                                        ),
                                      ),
                              ])),
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
