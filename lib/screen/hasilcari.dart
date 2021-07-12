import 'dart:math';

import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/screen/detail.dart';

class Cari extends StatefulWidget {
  String query;
  Cari({Key key, this.query}) : super(key: key);

  @override
  _CariState createState() => _CariState();
}

class _CariState extends State<Cari> {
  bool komikLoad = false;
  List<Map<String, dynamic>> namakomik;
  List<Map<String, dynamic>> imgkomik;
  List<Map<String, dynamic>> chkomik;
  List<Map<String, dynamic>> link;
  List<Map<String, dynamic>> error;
  String url = "https://wrt.my.id/?s=";

  void fetchKomik() async {
    String tempBaseUrl = url.split(".my.id")[0] + ".my.id";
    String tempRoute = url.split(".my.id")[1] + widget.query;
    final webscraper = WebScraper(tempBaseUrl);
    if (await webscraper.loadWebPage(tempRoute)) {
      imgkomik = webscraper.getElement(
          'div.listupd > div.bs > div.bsx > a > div.limit > img', ['src']);

      namakomik = webscraper
          .getElement('div.listupd > div.bs > div.bsx > a ', ['title']);
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
    fetchKomik();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(228, 68, 238, 1),
          title: Text("Cari " + widget.query),
        ),
        body: (komikLoad == true)
            ? Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 34, 34, 1),
                ),
                width: double.infinity,
                height: screensize.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      (namakomik.length > 0)
                          ? Wrap(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                for (var i = 0; i < namakomik.length; i++)
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 13),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 120,
                                            height: 150,
                                            child: Image.network(
                                              imgkomik[i]['attributes']['src'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (context, child,
                                                  loadingprogress) {
                                                if (loadingprogress == null)
                                                  return child;
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey),
                                                  width: 120,
                                                  height: 150,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors
                                                                  .deepPurple),
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
                                              namakomik[i]['attributes']
                                                  ['title'],
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              chkomik[i]['title']
                                                  .toString()
                                                  .trim(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
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
                                              lnk: link[i]['attributes']
                                                  ['href'],
                                              gambar: imgkomik[i]['attributes']
                                                  ['src'],
                                              nama: namakomik[i]['attributes']
                                                  ['title'])));
                                    },
                                  ),
                              ],
                            )
                          : Container(
                              width: double.infinity,
                              color: Color.fromRGBO(34, 34, 34, 1),
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                  child: Text(
                                "Nggak Ada Kak",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )),
                            )
                    ],
                  ),
                ))
            : Container(
                width: double.infinity,
                color: Color.fromRGBO(34, 34, 34, 1),
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )),
              ));
    //
  }
}
