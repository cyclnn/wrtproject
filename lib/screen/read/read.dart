import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/komen/komen.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrtproject/screen/lapor/lapor.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Read extends StatefulWidget {
  final String link, linkkomik, namakom, linkdet, img, id;
  final int urut;
  const Read(
      {Key key,
      this.link,
      this.id,
      this.linkkomik,
      this.urut,
      this.namakom,
      this.linkdet,
      this.img})
      : super(key: key);
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  List<Map<String, dynamic>> core;
  List<Map<String, dynamic>> habib;
  List<Map<String, dynamic>> prev;
  List<Map<String, dynamic>> linkch;
  List<Map<String, dynamic>> blogger;
  List<Map<String, dynamic>> imgbox;
  List<Map<String, dynamic>> kc;
  List<Map<String, dynamic>> namach;
  List<Map<String, dynamic>> komen;
  List<Map<String, dynamic>> ch;
  String akhir2, akhir3;
  var panjang, url;
  var preferences;

  int load = 0;

  void fetchInfo() async {
    String tempBaseUrl = widget.link.split(".my.id")[0] + ".my.id";
    String tempRoute = widget.link.split(".my.id")[1];

    final scraper = WebScraper(tempBaseUrl);
    if (await scraper.loadWebPage(tempRoute)) {
      core = scraper.getElement("div.habib > #readerarea > img", ['src']);
      habib = scraper.getElement("div.habib > p > img", ['src']);
      imgbox = scraper.getElement("div.habib > p > a > img", ['src']);
      kc = scraper.getElement("div.habib > div > img", ['src']);
      blogger = scraper.getElement("div.habib > div.separator > a", ['href']);
      komen = scraper.getElement("div.torang > a", ['href']);
      prev = scraper.getElement(
          "span.navlef > span.npv > div.nextprev > a.ch-prev-btn", ['href']);
      ch = scraper.getElement("div.headpost > h1", []);

      String akhir = ch[0]['title'].split("Chapter")[1];
      akhir2 = akhir.split("Bahasa")[0];
      akhir3 = akhir.split("Bahasa")[0];
      

      setState(() {
        if (blogger.length > 1) {
          panjang = blogger.length;
          url = blogger;
        } else if (core.length > 1) {
          panjang = core.length;
          url = core;
        } else if (habib.length > 1) {
          panjang = habib.length;
          url = habib;
        } else if (imgbox.length > 1) {
          panjang = imgbox.length;
          url = imgbox;
        } else if (kc.length > 1) {
          panjang = kc.length;
          url = kc;
        }
        akhir3 = akhir.split("Bahasa")[0];
        load = 1;
      });
    }
  }

  recent() async {
    preferences = await StreamingSharedPreferences.instance;
    return Future.delayed(const Duration(seconds: 8), () async {
      preferences.setString("hcap " + widget.id, "Chapter" + akhir2);
      preferences.setString("hurl " + widget.id, widget.link);
      preferences.setInt("hurut " + widget.id, widget.urut);
      preferences.setString("hid " + widget.id, widget.id);
    });
  }

  recentopen() async {}

  void fetchlink() async {
    String tempBaseUrl = widget.linkkomik.split(".my.id")[0] + ".my.id";
    String tempRoute = widget.linkkomik.split(".my.id")[1];

    final scraper = WebScraper(tempBaseUrl);
    if (await scraper.loadWebPage(tempRoute)) {
      linkch = scraper.getElement(
          "div.eplister > ul > li > div.chbox > div.eph-num > a ", ['href']);
    }
  }

  int selesai;

  @override
  void initState() {
    super.initState();
    fetchInfo();
    fetchlink();
    recent();
    recentopen();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    var gbr = widget.img;

    return (load == 1)
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              // Try removing opacity to observe the lack of a blur effect and of sliding content.
              backgroundColor: Const.baseColor,
              middle: Text(
                "Chapter" + akhir2,
                style: TextStyle(color: Const.text3),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    builder: (context) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.warning),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Lapor()));
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.settings),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.message),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .push(PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Komen(
                                                  lnk: komen[0]['attributes']
                                                      ['href'],
                                                )));
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ],
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Image.network(gbr),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 250,
                                            child: Text(
                                              widget.namakom,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text("Chapter" + akhir2,
                                              style: TextStyle(fontSize: 15)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (widget.urut < linkch.length)
                                      ? IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () {
                                            Navigator.of(context).pop();

                                            Navigator.of(context)
                                                .pushReplacement(PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: Read(
                                                      img: gbr,
                                                      id: widget.id,
                                                      urut: widget.urut + 1,
                                                      linkkomik:
                                                          widget.linkkomik,
                                                      link: linkch[widget.urut +
                                                              1]['attributes']
                                                          ['href'],
                                                      namakom: widget.namakom,
                                                    )));
                                          })
                                      : SizedBox(),
                                  (widget.urut != 0)
                                      ? IconButton(
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushReplacement(PageTransition(
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: Read(
                                                      img: gbr,
                                                      id: widget.id,
                                                      urut: widget.urut - 1,
                                                      linkkomik:
                                                          widget.linkkomik,
                                                      link: linkch[widget.urut -
                                                              1]['attributes']
                                                          ['href'],
                                                      namakom: widget.namakom,
                                                    )));
                                          })
                                      : SizedBox(
                                          height: 0,
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                color: Const.bgcolor,
                width: double.infinity,
                child: ListView(physics: BouncingScrollPhysics(), children: [
                  (url != blogger)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < panjang; i++)
                              Container(
                                decoration: BoxDecoration(color: Const.bgcolor),
                                width: double.infinity,
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: url[i]['attributes']['src'],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      width: double.infinity,
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Const.text2),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      width: 120,
                                      height: 150,
                                      child: Center(
                                        child: Icon(
                                          Icons.error,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < panjang; i++)
                              Container(
                                width: double.infinity,
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: url[i]['attributes']['href'],
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      width: double.infinity,
                                      height: 250,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Const.text2),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      width: 120,
                                      height: 150,
                                      child: Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Const.text2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                ]),
              ),
            ))
        : Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: screensize.height,
                  decoration: BoxDecoration(color: Const.bgcolor),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Const.text2),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Loading...",
                          style: TextStyle(fontSize: 18, color: Const.text2),
                        )
                      ],
                    ),
                  ))
            ],
          );
  }
}
