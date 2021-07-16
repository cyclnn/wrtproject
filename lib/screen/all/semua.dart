import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/detailpage/detail.dart';

class AllKom extends StatefulWidget {
  TabController controller;
  int awal;

  AllKom(this.controller, this.awal);

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

  @override
  void initState() {
    super.initState();
    fetchKomik(num + 1);
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
                      children: [
                        for (var i = 0; i < namakomik.length; i++)
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(left: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 130,
                                    height: 150,
                                    child: Image.network(
                                      imgkomik[i]['attributes']['src'],
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingprogress) {
                                        if (loadingprogress == null)
                                          return child;
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Const.cardcolor),
                                          width: 120,
                                          height: 150,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.deepPurple),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      namakomik[i]['attributes']['title'],
                                      style: TextStyle(color: Const.text2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      chkomik[i]['title'].toString().trim(),
                                      style: TextStyle(
                                          color: Const.textsm2, fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: Detail(
                                      lnk: link[i]['attributes']['href'],
                                      gambar: imgkomik[i]['attributes']['src'],
                                      nama: namakomik[i]['attributes']
                                          ['title'])));
                            },
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton.icon(
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
                                )),
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
