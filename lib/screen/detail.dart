import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:wrtproject/screen/chapter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/screen/home.dart';
import 'package:wrtproject/screen/komen.dart';
import 'package:wrtproject/screen/read.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrtproject/mesin/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wrtproject/screen/detail_genre.dart';
import 'package:flutter/cupertino.dart';

class Detail extends StatefulWidget {
  final String lnk, nama, gambar;
  final int urut, id;
  const Detail({Key key, this.lnk, this.nama, this.gambar, this.urut, this.id})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool load = false;
  String habib;

  List<Map<String, dynamic>> image;
  List<Map<String, dynamic>> sinop;
  List<Map<String, dynamic>> sinop2;
  List<Map<String, dynamic>> info;
  List<Map<String, dynamic>> jalt;
  List<Map<String, dynamic>> rilis;
  List<Map<String, dynamic>> status;
  List<Map<String, dynamic>> genre;
  List<Map<String, dynamic>> list;
  List<Map<String, dynamic>> lastup;
  List<Map<String, dynamic>> chtime;
  List<Map<String, dynamic>> linkch;
  List<Map<String, dynamic>> id;
  List<Map<String, dynamic>> linkgenre;
  List<Map<String, dynamic>> komentar;
  List<Map<String, dynamic>> sinop3;
  List<Map<String, dynamic>> sinop4;
  List<Map<String, dynamic>> sinop5;
  var panjang, isi, hcap, hurl, hurut, hid, idd;

  double _sigmaX = 10; // from 0-10
  double _sigmaY = 10; // from 0-10
  double _opacity = 0.5; // from 0-1.0

  void fetchInfo() async {
    String tempBaseUrl = widget.lnk.split(".my.id")[0] + ".my.id";
    String tempRoute = widget.lnk.split(".my.id")[1];

    final scraper = WebScraper(tempBaseUrl);
    if (await scraper.loadWebPage(tempRoute)) {
      image = scraper.getElement(
          "div.bigcontent > div.thumbook > div.thumb > img", ['src']);

      sinop = scraper.getElement(
          "div.bigcontent > div.infox > div.wd-full > div.entry-content > p",
          []);
      sinop4 = scraper.getElement(
          "div.bigcontent > div.infox > div.wd-full > div.entry-content > div > p",
          []);
      sinop2 = scraper.getElement("div.entry-content > p > span", []);
      sinop3 = scraper.getElement("#tw-target-text-container> span", []);
      sinop5 = scraper.getElement("#tw-target-text-container > p > span", []);

      jalt = scraper
          .getElement("div.bigcontent > div.infox > div.wd-full > span", []);

      rilis = scraper.getElement(
          "div.bigcontent > div.infox > div.flex-wrap > div.fmed ", ['title']);
      status = scraper.getElement(
          "div.bigcontent > div.thumbook > div.rt > div.tsinfo", ['title']);
      genre = scraper.getElement(
          "div.bigcontent > div.infox > div.wd-full > span > a", []);
      list =
          scraper.getElement("div.bixbox > div.eplister > ul > li", ['title']);
      lastup = scraper.getElement(
          "div.bigcontent > div.infox > div.flex-wrap > div.fmed > span > time",
          []);
      chtime = scraper.getElement(
          "div.eplister > ul > li > div.chbox > div.eph-num > a > span.chapterdate",
          []);
      linkch = scraper.getElement(
          "div.eplister > ul > li > div.chbox > div.eph-num > a ", ['href']);
      linkgenre = scraper.getElement(
          "div.bigcontent > div.infox > div.wd-full > span.mgen > a ",
          ['href']);
      komentar = scraper.getElement("div.torang > a ", ['href']);

      id = scraper.getElement("article", ['id']);

      get() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        idd = id[0]['attributes']['id'];
        hcap = prefs.getString("hchap " + idd);
        hurl = prefs.getString("hurl " + idd);
        hurut = prefs.getInt("hurut" + idd);
        hid = prefs.getString("hid " + idd);
      }

      setState(() {
        if (sinop.length > 0) {
          panjang = sinop.length;
          isi = sinop;
        } else if (sinop2.length > 0) {
          panjang = sinop2.length;
          isi = sinop2;
        } else if (sinop3.length > 0) {
          panjang = sinop3.length;
          isi = sinop3;
        } else if (sinop4.length > 0) {
          panjang = sinop4.length;
          isi = sinop4;
        } else {
          panjang = sinop5.length;
          isi = sinop5;
        }
        load = true;
        print(sinop3.length);
        get();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(228, 68, 238, 1),
        title: Text('Detail Manga'),
      ),
      body: load
          ? Container(
              width: double.infinity,
              height: screensize.height,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(22, 21, 29, 1),
                  image: DecorationImage(
                      image: NetworkImage(widget.gambar), fit: BoxFit.fill)),
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                    child: Container(
                      color: Colors.black.withOpacity(_opacity),
                    ),
                  ),
                  SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      32 /
                                      100,
                                  height: 180,
                                  child: Image.network(
                                    widget.gambar,
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (context, child, loadingprogress) {
                                      if (loadingprogress == null) return child;
                                      return Container(
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                32 /
                                                100,
                                        height: 150,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      60 /
                                      100,
                                  height: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.nama,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        if (Database.getData(
                                                id[0]['attributes']['id']) !=
                                            null)
                                          SizedBox(
                                            width: 120,
                                            height: 30,
                                            child: FlatButton.icon(
                                                color: Colors.redAccent,
                                                onPressed: () async {
                                                  try {
                                                    Database.createOrupdate(
                                                            id[0]['attributes']
                                                                ['id'],
                                                            nama: widget.nama,
                                                            link: widget.lnk,
                                                            img: widget.gambar)
                                                        .then((value) => Navigator
                                                            .pushReplacement(
                                                                context,
                                                                PageTransition(
                                                                    type: PageTransitionType
                                                                        .leftToRight,
                                                                    child:
                                                                        Home())));
                                                  } on FirebaseAuthException catch (e) {
                                                    Alert(
                                                            context: context,
                                                            title: "Error",
                                                            desc: e.message)
                                                        .show();
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                label: Text(
                                                  "Bookmark",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jalt[0]['title'].toString().trim(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 4),
                                      child: Text(
                                        "Tahun Rilis : " +
                                            rilis[0]['attributes']['title']
                                                .toString()
                                                .trim(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 4),
                                      child: Text(
                                        "Status : " +
                                            status[0]['attributes']['title']
                                                .toString()
                                                .trim(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 4),
                                      child: Text(
                                        "Author : " +
                                            rilis[1]['attributes']['title']
                                                .toString()
                                                .trim(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 4),
                                      child: Text(
                                        "Last Update : " + lastup[0]['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 4),
                                      child: Text(
                                        "Posted By : " +
                                            rilis[5]['attributes']['title']
                                                .toString()
                                                .trim(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: (sinop.length > 1)
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SINOPSIS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                          for (var i = 0; i < sinop.length; i++)
                                            Text(
                                              sinop[i]['title']
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14),
                                            ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SINOPSIS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                          for (var i = 0; i < panjang; i++)
                                            Text(
                                              isi[i]['title'].toString().trim(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14),
                                            ),
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "GENRE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Wrap(children: [
                                          for (var i = 0; i < genre.length; i++)
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    right: 5,
                                                    bottom: 6),
                                                child: GestureDetector(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.5)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          genre[i]['title']
                                                              .toString()
                                                              .trim(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .bottomToTop,
                                                            child: Detgen(
                                                                url: linkgenre[
                                                                            i][
                                                                        'attributes']
                                                                    ['href'],
                                                                nama: genre[i][
                                                                    'title'])));
                                                  },
                                                )),
                                        ])
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "RECENT READ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 45,
                                        child: GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0, right: 5, bottom: 15),
                                            child: Container(
                                                height: 25,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1))),
                                                child: Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      (hcap != null)
                                                          ? Text(
                                                              "Chapter" +
                                                                  hcap.toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          : Center(
                                                              child: Text(
                                                                "Belum Ada History",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: Read(
                                                      link: hurl.toString(),
                                                      linkkomik: widget.lnk,
                                                      urut: hurut,
                                                      id: id[0]['attributes']
                                                          ['id'],
                                                      linkdet: widget.lnk,
                                                      namakom: widget.nama,
                                                      img: widget.gambar,
                                                    )));
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "LIST CHAPTER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: ListView(
                                          physics: ClampingScrollPhysics(),
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(children: [
                                                  for (var i = 0;
                                                      i < list.length;
                                                      i++)
                                                    GestureDetector(
                                                      child: Chapter(
                                                          chap:
                                                              list[i]['attributes']
                                                                      ['title']
                                                                  .toString()
                                                                  .trim(),
                                                          timech: chtime[i]
                                                              ['title']),
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            PageTransition(
                                                                type: PageTransitionType
                                                                    .bottomToTop,
                                                                child: Read(
                                                                  link: linkch[
                                                                              i]
                                                                          [
                                                                          'attributes']
                                                                      ['href'],
                                                                  linkkomik:
                                                                      widget
                                                                          .lnk,
                                                                  urut: i,
                                                                  id: id[0][
                                                                          'attributes']
                                                                      ['id'],
                                                                  linkdet:
                                                                      widget
                                                                          .lnk,
                                                                  namakom:
                                                                      widget
                                                                          .nama,
                                                                  img: widget
                                                                      .gambar,
                                                                )));
                                                      },
                                                    )
                                                ])
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(34, 34, 34, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "KOMENTAR",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: Komen(
                                                      lnk: komentar[0]
                                                              ['attributes']
                                                          ['href'],
                                                    )));
                                          },
                                          color: Colors.red,
                                          child: Text(
                                            "Komentar",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )
          : Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: screensize.height,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(22, 21, 29, 1)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Loading...",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                    ))
              ],
            ),
    );
  }
}
