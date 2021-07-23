import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wrtproject/screen/detailpage/chapter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/screen/komen/komen.dart';
import 'package:wrtproject/screen/loading/loading.dart';
import 'package:wrtproject/screen/nullpage/page.dart';
import 'package:wrtproject/screen/read/read.dart';
import 'package:wrtproject/screen/genrepage/detail_genre.dart';
import 'package:flutter/cupertino.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Detail extends StatefulWidget {
  final int ads;
  final String lnk, nama, gambar;
  final int urut, id;
  const Detail(
      {Key key, this.lnk, this.nama, this.gambar, this.urut, this.id, this.ads})
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
  List<Map<String, dynamic>> views;
  List<Map<String, dynamic>> rating;
  var panjang, isi, idd;
  Preference hurl, hcap;
  Preference hid;
  Preference hurut;
  var preferences;
  var moderead;

  double _sigmaX = 10; // from 0-10
  double _sigmaY = 10; // from 0-10
  double _opacity = 0.5; // from 0-1.0

  void main() async {
    await Hive.openBox('title');
    await Hive.openBox('gambar');
    await Hive.openBox('url');
    await Hive.openBox('idbookmark');
  }

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
      views = scraper.getElement(
          "div.bigcontent > div.infox > div.flex-wrap > div.fmed > span", []);
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
      rating = scraper.getElement(
          "div.bigcontent > div.thumbook > div.rt > div.rating > div.rating-prc > div.num",
          []);

      id = scraper.getElement("article", ['id']);

      get() async {
        preferences = await StreamingSharedPreferences.instance;
        idd = id[0]['attributes']['id'];
        hcap = preferences.getString("hcap " + idd, defaultValue: "No History");
        hurl = preferences.getString("hurl " + idd, defaultValue: "null");
        hurut = preferences.getInt("hurut " + idd);
        hid = preferences.getString("hid " + idd);
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
        get();
      });
    }
  }

  void bookmark() async {
    var title = await Hive.openBox('title');
    title.add(widget.nama); // index 0, key 0

    var url = await Hive.openBox('url');
    url.add(widget.lnk); // index 0, key 0

    var gambar = await Hive.openBox('gambar');
    gambar.add(widget.gambar); // index 0, key 0

    var id = await Hive.openBox('idbookmark');
    id.put(idd, idd);
  }

  void delbookmark() async {
    var id = Hive.box('idbookmark');

    for (var i = 0; i <= id.length; i++) {
      if (id.getAt(i) == idd) {
        var title = Hive.box('title');
        title.deleteAt(i);

        var url = Hive.box('url');
        url.deleteAt(i); // index 0, key 0

        var gambar = Hive.box('gambar');
        gambar.deleteAt(i); // index 0, key 0

        id.deleteAt(i);
      }
    }
  }

  void cekRead() async {
    SharedPreferences mode = await SharedPreferences.getInstance();
    moderead = mode.getInt("readmode");
    return moderead;
  }

  final BannerAd myBanner = BannerAd(
    adUnitId: Const.banner1,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  InterstitialAd _interstitialAd;

  void ads2() {
    InterstitialAd.load(
        adUnitId: Const.ins1,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  RewardedAd _rewardedAd;
  void ads3() {
    RewardedAd.load(
        adUnitId: Const.rewarded1,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchInfo();
    main();
    setState(() {
      fetchInfo();
    });
    cekRead();
    if (widget.ads == 2) ads3();
    ads2();
    myBanner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
    _rewardedAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    var cek = Hive.box('idbookmark');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Const.baseColor,
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
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        color: Const.baseColor.withOpacity(_opacity),
                      ),
                    ),
                    SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        32 /
                                        100,
                                    height: 200,
                                    child: Image.network(
                                      widget.gambar,
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingprogress) {
                                        if (loadingprogress == null)
                                          return child;
                                        return Container(
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.nama,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GFRating(
                                                    color: Colors.red,
                                                    borderColor: Colors.red,
                                                    size: 25,
                                                    allowHalfRating: true,
                                                    value: double.parse(
                                                            rating[0]
                                                                ['title']) /
                                                        2.0,
                                                    onChanged: (value) {},
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    rating[0]['title']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          (cek.get(idd) != idd)
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    bookmark();
                                                    setState(() {
                                                      cek.get(idd);
                                                    });
                                                  },
                                                  child: AnimatedContainer(
                                                      height: 40,
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      color: Colors.redAccent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.favorite,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Text(
                                                            "Bookmark",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      )),
                                                )
                                              : GestureDetector(
                                                  onTap: () async {
                                                    delbookmark();
                                                    setState(() {
                                                      cek.get(idd);
                                                    });
                                                  },
                                                  child: AnimatedContainer(
                                                      height: 40,
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      color: Colors.greenAccent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.favorite,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          Text(
                                                            "Bookmarked",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      )),
                                                )
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4, bottom: 4),
                                        child: (views.length < 7)
                                            ? Text(
                                                "Views : " +
                                                    views[4]['title']
                                                        .toString()
                                                        .trim(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14),
                                              )
                                            : Text(
                                                "Views : " +
                                                    views[6]['title']
                                                        .toString()
                                                        .trim(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                            for (var i = 0;
                                                i < sinop.length;
                                                i++)
                                              Text(
                                                sinop[i]['title']
                                                    .toString()
                                                    .trim(),
                                                style:
                                                    GoogleFonts.archivoNarrow(
                                                        textStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14)),
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
                                                isi[i]['title']
                                                    .toString()
                                                    .trim(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            for (var i = 0;
                                                i < genre.length;
                                                i++)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 5,
                                                          bottom: 6),
                                                  child: GestureDetector(
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
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
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )),
                                                    onTap: () {
                                                      Get.to(
                                                          () => Detgen(
                                                              url: linkgenre[i][
                                                                      'attributes']
                                                                  ['href'],
                                                              nama: genre[i]
                                                                  ['title']),
                                                          transition:
                                                              Transition.zoom);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  left: 0,
                                                  right: 5,
                                                  bottom: 15),
                                              child: Container(
                                                  height: 25,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        PreferenceBuilder<
                                                                String>(
                                                            preference: hcap,
                                                            builder: (BuildContext
                                                                        context,
                                                                    String
                                                                        snapshot) =>
                                                                Text(
                                                                  snapshot
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ))
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            onTap: () async {
                                              Get.to(
                                                      () => PreferenceBuilder<
                                                              int>(
                                                          preference: hurut,
                                                          builder: (BuildContext
                                                                      context,
                                                                  int hurutt) =>
                                                              PreferenceBuilder<
                                                                  String>(
                                                                preference:
                                                                    hurl,
                                                                builder: (BuildContext
                                                                            context,
                                                                        String
                                                                            hurll) =>
                                                                    PreferenceBuilder<
                                                                        String>(
                                                                  preference:
                                                                      hid,
                                                                  builder: (BuildContext
                                                                              context,
                                                                          String
                                                                              hidd) =>
                                                                      (hurll != "null" ||
                                                                              hurll != null)
                                                                          ? Read(
                                                                              link: hurll,
                                                                              linkkomik: widget.lnk,
                                                                              urut: hurutt,
                                                                              id: hidd,
                                                                              linkdet: widget.lnk,
                                                                              namakom: widget.nama,
                                                                              img: widget.gambar,
                                                                            )
                                                                          : NullPage(),
                                                                ),
                                                              )),
                                                      transition:
                                                          Transition.zoom)
                                                  .then((value) {
                                                if (widget.ads == 1)
                                                  _interstitialAd.show();
                                                if (widget.ads == 2) {
                                                  _rewardedAd.show(
                                                      onUserEarnedReward:
                                                          (RewardedAd ad,
                                                              RewardItem
                                                                  rewardItem) {});
                                                }
                                              });
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                            chap: list[i][
                                                                        'attributes']
                                                                    ['title']
                                                                .toString()
                                                                .trim(),
                                                            timech: chtime[i]
                                                                ['title']),
                                                        onTap: () async {
                                                          Get.to(() => Read(
                                                                link: linkch[i][
                                                                        'attributes']
                                                                    ['href'],
                                                                linkkomik:
                                                                    widget.lnk,
                                                                urut: i,
                                                                id: id[0][
                                                                        'attributes']
                                                                    ['id'],
                                                                linkdet:
                                                                    widget.lnk,
                                                                namakom:
                                                                    widget.nama,
                                                                img: widget
                                                                    .gambar,
                                                              )).then((value) {
                                                            if (widget.ads == 1)
                                                              _interstitialAd
                                                                  .show();
                                                            if (widget.ads ==
                                                                2) {
                                                              _rewardedAd.show(
                                                                  onUserEarnedReward:
                                                                      (RewardedAd
                                                                              ad,
                                                                          RewardItem
                                                                              rewardItem) {});
                                                            }
                                                          });
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: Komen(
                                                        lnk: komentar[0]
                                                                ['attributes']
                                                            ['href'],
                                                      )));
                                            },
                                            color: Colors.red,
                                            child: Text(
                                              "Komentar",
                                              style: TextStyle(
                                                  color: Colors.white),
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
            : loadingScreen(screensize));
  }
}
