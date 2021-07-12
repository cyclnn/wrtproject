import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/screen/detail.dart';

class Detgen extends StatefulWidget {
  final url, nama;
  const Detgen({Key key, this.url, this.nama}) : super(key: key);

  @override
  _DetgenState createState() => _DetgenState();
}

class _DetgenState extends State<Detgen> {
  bool komikLoad = false;
  int num = 1;
  List<Map<String, dynamic>> namakomik;
  List<Map<String, dynamic>> imgkomik;
  List<Map<String, dynamic>> chkomik;
  List<Map<String, dynamic>> hot;
  List<Map<String, dynamic>> link;

  void fetchKomik(nilai) async {
    String tempBaseUrl = widget.url.split(".my.id")[0] + ".my.id";
    String tempRoute =
        widget.url.split(".my.id")[1] + "page/" + num.toString() + "/";
    final webscraper = WebScraper(tempBaseUrl);
    if (await webscraper.loadWebPage(tempRoute)) {
      imgkomik = webscraper.getElement(
          'div.listupd > div.bs > div.bsx > a > div.limit > img', ['src']);

      namakomik = webscraper
          .getElement('div.listupd > div.bs > div.bsx > a ', ['title']);
      chkomik = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.bigor > div.adds > div.epxs",
          []);
      link = webscraper
          .getElement('div.listupd > div.bs > div.bsx > a ', ['href']);
      hot = webscraper.getElement(
          "div.listupd > div.bs > div.bsx > a > div.limit > span.hot",
          ['class']);

      setState(() {
        komikLoad = true;
        print(tempRoute);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(228, 68, 238, 1),
        title: Text(widget.nama),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(34, 34, 34, 1),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
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
                                    Stack(
                                      children: <Widget>[
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
                                                            Colors.deepPurple),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: Container(
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            child: Center(
                                              child: Text(
                                                "Manga",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: 120,
                                      child: Text(
                                        namakomik[i]['attributes']['title'],
                                        style: TextStyle(color: Colors.white),
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
                                            color: Colors.grey, fontSize: 12),
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
                                        gambar: imgkomik[i]['attributes']
                                            ['src'],
                                        nama: namakomik[i]['attributes']
                                            ['title'])));
                              },
                            ),
                          (namakomik.length > 9)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                )
                              : SizedBox(
                                  height: 20,
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
          )),
    );
  }
}
