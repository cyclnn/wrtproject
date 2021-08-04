import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../detailpage/detail.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var myController = TextEditingController();
  bool typing = false;
  int state = 0;
  bool komikLoad = false;
  List<Map<String, dynamic>> namakomik;
  List<Map<String, dynamic>> imgkomik;
  List<Map<String, dynamic>> chkomik;
  List<Map<String, dynamic>> link;
  List<Map<String, dynamic>> error;
  String url = "https://wrt.my.id/?s=";

  void fetchKomik() async {
    String tempBaseUrl = url.split(".my.id")[0] + ".my.id";
    String tempRoute = url.split(".my.id")[1] + myController.text;
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
    Map<String, String> header = {"referer": "https://wrt.my.id"};

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Const.baseColor,
            title: Container(
              height: 38,
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Search'),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      fetchKomik();
                      komikLoad = false;
                    });
                  },
                ),
              ),
            ]),
        body: (komikLoad == true)
            ? Center(
                child: Container(
                    decoration: BoxDecoration(
                      color: Const.bgcolor,
                    ),
                    height: screensize.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          (namakomik.length > 0)
                              ? Center(
                                  child: Wrap(
                                    children: [
                                      Container(
                                        width: screensize.width,
                                      ),
                                      for (var i = 0; i < namakomik.length; i++)
                                        GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(4),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          4),
                                                              topLeft: Radius
                                                                  .circular(4),
                                                              topRight: Radius
                                                                  .circular(4)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 4,
                                                              blurRadius: 5,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        width:
                                                            MediaQuery.maybeOf(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3.5,
                                                        height: 180,
                                                        child:
                                                            CachedNetworkImage(
                                                          httpHeaders: header,
                                                          imageUrl: imgkomik[i]
                                                                  ['attributes']
                                                              ['src'],
                                                          fit: BoxFit.fill,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Container(
                                                            width: 130,
                                                            height: 180,
                                                            child: Center(
                                                              child: SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .deepPurple),
                                                                  strokeWidth:
                                                                      2,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Container(
                                                  width: MediaQuery.maybeOf(
                                                              context)
                                                          .size
                                                          .width /
                                                      3.5,
                                                  child: Text(
                                                    namakomik[i]['attributes']
                                                        ['title'],
                                                    style: GoogleFonts.firaSans(
                                                        textStyle: TextStyle(
                                                            color: Const.text,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18)),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Container(
                                                  width: MediaQuery.maybeOf(
                                                              context)
                                                          .size
                                                          .width /
                                                      3.5,
                                                  child: Text(
                                                    chkomik[i]['title'],
                                                    style: GoogleFonts.firaSans(
                                                        textStyle: TextStyle(
                                                            color: Const.textsm,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 13)),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            Get.to(
                                                () => Detail(
                                                      lnk: link[i]['attributes']
                                                          ['href'],
                                                      gambar: imgkomik[i]
                                                          ['attributes']['src'],
                                                      nama: namakomik[i]
                                                              ['attributes']
                                                          ['title'],
                                                    ),
                                                transition:
                                                    Transition.downToUp);
                                          },
                                          onDoubleTap: () {},
                                        ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  color: Const.bgcolor,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                      child: Text(
                                    "Nggak Ada Kak",
                                    style: TextStyle(
                                        color: Const.text2, fontSize: 25),
                                  )),
                                )
                        ],
                      ),
                    )),
              )
            : Container(
                width: double.infinity,
                color: Const.bgcolor,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Const.text2),
                )),
              )
        // )
        );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
        ),
      ),
    );
  }
}
