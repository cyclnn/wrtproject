import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/database.dart';
import 'package:wrtproject/mesin/history.dart';
import 'package:wrtproject/screen/chatango.dart';
import 'package:wrtproject/screen/detail.dart';
import 'package:wrtproject/screen/populer.dart';
import 'package:wrtproject/screen/search.dart';
import 'package:wrtproject/screen/update.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  bool komikLoad = false;
  var udah = new List(30);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
        print(prefs.getInt('nilai'));
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
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(228, 68, 238, 1));
    FirebaseAuth auth = FirebaseAuth.instance;

    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(228, 68, 238, 1),
          title: Image.asset(
            "assets/img/lg.png",
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
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.bottomToTop, child: Chatango()));
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
                  Dash();
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
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.bottomToTop, child: Search()));
              },
              iconSize: 20,
            )
          ],
        ),
        body: komikLoad
            ? Container(
                decoration: BoxDecoration(color: Color.fromRGBO(22, 21, 29, 1)),
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
                      GestureDetector(
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
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(34, 34, 34, 1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4))),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
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
                                            Navigator.of(context).push(
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: Detail(
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
                                                    )));
                                          } else {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            prefs.setInt(
                                                'history$history', history);
                                            prefs.setInt('nilai', history);
                                            Navigator.of(context).push(
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: Detail(
                                                      lnk: link[i]['attributes']
                                                          ['href'],
                                                      gambar: hotlist[i]
                                                          ['attributes']['src'],
                                                      nama: hotnama[i]
                                                              ['attributes']
                                                          ['title'],
                                                      urut: i,
                                                      id: 100,
                                                    )));
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
                            color: Color.fromRGBO(34, 34, 34, 1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4))),
                        margin: EdgeInsets.only(top: 8),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'UPDATE WRT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Wrap(
                              children: [
                                for (var i = 0; i < 15; i++)
                                  GestureDetector(
                                    child: UpdatePJ(
                                      komikImg: komiklist[i]['attributes']
                                          ['src'],
                                      komikTitle: namalist[i]['attributes']
                                          ['title'],
                                      ch: chlist[i]['attributes']['title'],
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: Detail(
                                              lnk: linkup[i]['attributes']
                                                  ['href'],
                                              gambar: komiklist[i]['attributes']
                                                  ['src'],
                                              nama: namalist[i]['attributes']
                                                  ['title'])));
                                    },
                                    onLongPress: () {
                                      Navigator.of(context).push(PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: Bookm(),
                                      ));
                                    },
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(34, 34, 34, 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4))),
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
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
                                    : FutureBuilder(
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
                                            return Wrap(
                                              children: [
                                                for (var i = 15; i < 39; i++)
                                                  GestureDetector(
                                                    child: UpdatePJ(
                                                      komikImg: komiklist[i]
                                                          ['attributes']['src'],
                                                      komikTitle: namalist[i]
                                                              ['attributes']
                                                          ['title'],
                                                      ch: chlist[i]
                                                              ['attributes']
                                                          ['title'],
                                                    ),
                                                    onTap: () {
                                                      Navigator.of(context).push(PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .bottomToTop,
                                                          child: Detail(
                                                              lnk: linkup[i][
                                                                      'attributes']
                                                                  ['href'],
                                                              gambar: komiklist[
                                                                          i]
                                                                      ['attributes']
                                                                  ['src'],
                                                              nama: namalist[i]
                                                                      ['attributes']
                                                                  ['title'])));
                                                      History.createOrupdate(1,
                                                          nama: namalist[i]
                                                                  ['attributes']
                                                              ['title'],
                                                          img: komiklist[i]
                                                                  ['attributes']
                                                              ['src'],
                                                          link: linkup[i]
                                                                  ['attributes']
                                                              ['href']);
                                                    },
                                                  )
                                              ],
                                            );
                                        },
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
                color: Color.fromRGBO(34, 34, 34, 1),
                width: double.infinity,
                height: screensize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/lg.png",
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.deepPurple),
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
