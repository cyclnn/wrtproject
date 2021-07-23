import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/detailpage/detail.dart';
import 'package:wrtproject/screen/Home/update.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AllKom extends StatefulWidget {
  TabController controller;
  int awal;
  int ads3, ads2;

  AllKom(this.controller, this.awal, this.ads3, this.ads2);

  @override
  _AllKomState createState() => _AllKomState();
}

class _AllKomState extends State<AllKom> {
  bool komikLoad = false;
  int num = 1;
  List<Map<String, dynamic>> namakomik;
  List<Map<String, dynamic>> imgkomik;
  List<Map<String, dynamic>> chkomik;
  List<Map<String, dynamic>> link;
  String url = "https://wrt.my.id/manga/?page=";

  void fetchKomik(nilai) async {
    String tempBaseUrl = url.split(".my.id")[0] + ".my.id";
    String tempRoute = url.split(".my.id")[1] + nilai.toString();
    final webscraper = WebScraper(tempBaseUrl);
    if (await webscraper.loadWebPage(tempRoute)) {
      imgkomik = webscraper.getElement(
          'div.mrgn > div.listupd > div.bs > div.bsx > a > div.limit > img',
          ['src']);

      namakomik = webscraper.getElement(
          'div.mrgn > div.listupd > div.bs > div.bsx > a ', ['title']);
      chkomik = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.bigor > div.adds > div.epxs",
          []);
      link =
          webscraper.getElement("div.listupd > div.bs > div.bsx > a", ['href']);

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
    if (widget.ads3 == 1) ads();
    fetchKomik(num + 1);
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
                  'SEMUA KOMIK (PAGE $num)',
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
                        for (var i = 0; i < namakomik.length; i++)
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
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () async {
                              if (widget.ads3 == 1)
                                await _interstitialAd.show();
                              Navigator.of(context).push(PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: Detail(
                                      lnk: link[i]['attributes']['href'],
                                      ads: widget.ads2,
                                      gambar: imgkomik[i]['attributes']['src'],
                                      nama: namakomik[i]['attributes']
                                          ['title'])));
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
