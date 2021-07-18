import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/komen/komen.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrtproject/screen/lapor/lapor.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Mode3 extends StatefulWidget {
  final String link, linkkomik, namakom, linkdet, img, id;
  final int urut;
  const Mode3(
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
  _Mode3State createState() => _Mode3State();
}

class _Mode3State extends State<Mode3> {
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
      core = scraper.getElement("#readerarea", []);
      komen = scraper.getElement("div.torang > a", ['href']);
      prev = scraper.getElement(
          "span.navlef > span.npv > div.nextprev > a.ch-prev-btn", ['href']);
      ch = scraper.getElement("div.headpost > h1", []);

      String akhir = ch[0]['title'].split("Chapter")[1];
      akhir2 = akhir.split("Bahasa")[0];
      akhir3 = akhir.split("Bahasa")[0];

      setState(() {
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

  void fetchlink() async {
    String tempBaseUrl = widget.linkkomik.split(".my.id")[0] + ".my.id";
    String tempRoute = widget.linkkomik.split(".my.id")[1];

    final scraper = WebScraper(tempBaseUrl);
    if (await scraper.loadWebPage(tempRoute)) {
      linkch = scraper.getElement(
          "div.eplister > ul > li > div.chbox > div.eph-num > a ", ['href']);
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  int selesai;

  @override
  void initState() {
    super.initState();
    fetchInfo();
    fetchlink();
    recent();
  }

  @override
  Widget build(BuildContext context) {
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
                                                    child: Mode3(
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
                                                    child: Mode3(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Const.bgcolor),
                        width: double.infinity,
                        child: Center(child: HtmlWidget(core[0]['title'])),
                      ),
                    ],
                  )
                ]),
              ),
            ))
        : Container(
            color: Const.bgcolor,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
                strokeWidth: 2,
              ),
            ),
          );
  }
}
