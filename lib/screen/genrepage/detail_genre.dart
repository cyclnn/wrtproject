import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/detailpage/detail.dart';

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
        backgroundColor: Const.baseColor,
        title: Text(widget.nama),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Const.bgcolor,
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
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i = 0; i < namakomik.length; i++)
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4),
                                                  topLeft: Radius.circular(4),
                                                  topRight: Radius.circular(4)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 4,
                                                  blurRadius: 5,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            width: MediaQuery.maybeOf(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: 160,
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
                                                  width: MediaQuery.maybeOf(
                                                              context)
                                                          .size
                                                          .width /
                                                      3.5,
                                                  height: 160,
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
                                        ]),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: MediaQuery.maybeOf(context)
                                              .size
                                              .width /
                                          3.5,
                                      child: Text(
                                        namakomik[i]['attributes']['title'],
                                        style: GoogleFonts.firaSans(
                                            textStyle: TextStyle(
                                                color: Const.text,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
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
                                Get.to(
                                    () => Detail(
                                          lnk: link[i]['attributes']['href'],
                                          gambar: imgkomik[i]['attributes']
                                              ['src'],
                                          nama: namakomik[i]['attributes']
                                              ['title'],
                                        ),
                                    transition: Transition.downToUp);
                              },
                              onDoubleTap: () {},
                            ),
                          (namakomik.length > 9)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
