import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:wrtproject/screen/detail_genre.dart';

class Genlist extends StatefulWidget {
  @override
  _GenlistState createState() => _GenlistState();
}

class _GenlistState extends State<Genlist> {
  bool komikLoad = false;
  int num = 1;
  List<Map<String, dynamic>> namagenre;
  List<Map<String, dynamic>> linkgenre;
  String url = "https://wrt.my.id";

  void fetchKomik() async {
    final webscraper = WebScraper(url);
    if (await webscraper.loadWebPage('')) {
      namagenre = webscraper
          .getElement('#sidebar > div.section > ul.genre > li > a', []);

      linkgenre = webscraper
          .getElement('#sidebar > div.section > ul.genre > li > a', ['href']);

      setState(() {
        komikLoad = true;
        print(linkgenre[1]['attributes']['href']);
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
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(228, 68, 238, 1),
        title: Text("Daftar Genre"),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(34, 34, 34, 1),
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.grey,
                ),
                komikLoad
                    ? Wrap(
                        children: [
                          for (var i = 0; i < namagenre.length; i++)
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 13, right: 13),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        width: double.infinity,
                                        height: 30,
                                        color: Colors.grey[200],
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                namagenre[i]['title'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageTransition(
                                                type: PageTransitionType
                                                    .bottomToTop,
                                                child: Detgen(
                                                    url: linkgenre[i]
                                                        ['attributes']['href'],
                                                    nama: namagenre[i]
                                                        ['title'])));
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {},
                            )
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
                      )
              ],
            ),
          )),
    );
  }
}
