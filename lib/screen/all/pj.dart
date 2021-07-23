import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/Home/update.dart';
import 'package:wrtproject/screen/detailpage/detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AllPj extends StatefulWidget {
  TabController controller;
  int ads3, ads2;

  AllPj(this.controller, this.ads3, this.ads2);

  @override
  _AllPjState createState() => _AllPjState();
}

class _AllPjState extends State<AllPj> {
  bool komikLoad = false;
  var akhir2;
  int num = 1;
  List<Map<String, dynamic>> namakomik;
  List<Map<String, dynamic>> imgkomik;
  List<Map<String, dynamic>> chkomik;
  List<Map<String, dynamic>> hot;
  List<Map<String, dynamic>> link;
  String url = "https://wrt.my.id/project-wrt/page/";

  void fetchKomik(nilai) async {
    String tempBaseUrl = url.split(".my.id")[0] + ".my.id";
    String tempRoute = url.split(".my.id")[1] + nilai.toString();
    final webscraper = WebScraper(tempBaseUrl);
    if (await webscraper.loadWebPage(tempRoute)) {
      imgkomik = webscraper.getElement(
          'div.listupd > div.bs > div.bsx > a > div.limit > img', ['src']);

      namakomik = webscraper
          .getElement('div.listupd > div.bs > div.bsx > a ', ['title']);
      link = webscraper
          .getElement('div.listupd > div.bs > div.bsx > a ', ['href']);
      chkomik = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.bigor > div.adds > div.epxs",
          []);
      hot = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.limit > span.hot",
          ['class']);

      setState(() {
        komikLoad = true;
      });
    }
  }

  InterstitialAd _interstitialAd;
  ads() async {
    if (widget.ads3 == 1) {
      await InterstitialAd.load(
          adUnitId: Const.ins2,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              _interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
            },
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchKomik(num + 1);
    if (widget.ads3 == 1) ads();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Const.bgcolor,
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'PROJECT WRT (PAGE $num)',
                  style: TextStyle(
                      color: Const.text2, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              komikLoad
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (var i = 0; i < 15; i++)
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  UpdatePJ2(
                                    komikImg: imgkomik[i]['attributes']['src'],
                                    komikTitle: namakomik[i]['attributes']
                                        ['title'],
                                    ch: chkomik[i]['title'].split("Chapter")[1],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              Navigator.of(context)
                                  .push(PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: Detail(
                                          lnk: link[i]['attributes']['href'],
                                          ads: widget.ads3,
                                          gambar: imgkomik[i]['attributes']
                                              ['src'],
                                          nama: namakomik[i]['attributes']
                                              ['title'])))
                                  .then((value) {
                                if (widget.ads3 == 1) _interstitialAd.show();
                              });
                            },
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (num > 1)
                                ? FlatButton.icon(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        komikLoad = false;
                                        fetchKomik(num--);
                                      });
                                    },
                                    label: Text(
                                      "Prev Page",
                                      style: TextStyle(color: Colors.white),
                                    ))
                                : SizedBox(),
                            SizedBox(
                              height: 20,
                            ),
                            FlatButton.icon(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    komikLoad = false;
                                    fetchKomik(num++);
                                  });
                                },
                                label: Text(
                                  "Next Page",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                      )),
                    )
            ],
          ),
        ));
  }
}
