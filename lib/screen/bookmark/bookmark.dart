import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wrtproject/screen/detailpage/detail.dart';
import 'package:get/get.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  int legt;
  bool load = false;

  getA() async {
    await Hive.openBox('title');
    await Hive.openBox('gambar');
    await Hive.openBox('url');
    var box = Hive.box('title');
    legt = box.length;
    setState(() {
      load = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getA();
  }

  @override
  Widget build(BuildContext context) {
    var title = Hive.box('title');
    var url = Hive.box('url');
    var gambar = Hive.box('gambar');
    var id = Hive.box('idbookmark');
    Size screensize = MediaQuery.of(context).size;
    return (load)
        ? Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Const.baseColor,
              title: Text("Bookmark (Beta)"),
            ),
            body: (legt != 0)
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
                              Center(
                                child: Wrap(
                                  children: [
                                    Container(
                                      width: screensize.width,
                                      margin: EdgeInsets.all(10),
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 4,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Bookmark Disimpan di Perangkat Anda, Jangan Hapus Data Aplikasi, Untuk Menghapus Bookmark Tekan Dan Tahan Komik",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    for (var i = 0; i < legt; i++)
                                      GestureDetector(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(4),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  4),
                                                          topLeft:
                                                              Radius.circular(
                                                                  4),
                                                          topRight:
                                                              Radius.circular(
                                                                  4)),
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
                                                width:
                                                    MediaQuery.maybeOf(context)
                                                            .size
                                                            .width /
                                                        3.5,
                                                height: 160,
                                                child: Image.network(
                                                  gambar.getAt(i),
                                                  fit: BoxFit.fill,
                                                  loadingBuilder: (context,
                                                      child, loadingprogress) {
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
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.maybeOf(context)
                                                            .size
                                                            .width /
                                                        3.5,
                                                child: Text(
                                                  title.getAt(i),
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
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                        onLongPress: () {
                                          title.deleteAt(i);
                                          gambar.deleteAt(i);
                                          url.deleteAt(i);
                                          id.deleteAt(i);
                                          setState(() {
                                            getA();
                                          });
                                        },
                                        onTap: () {
                                          Get.to(
                                              () => Detail(
                                                    lnk: url.getAt(i),
                                                    gambar: gambar.getAt(i),
                                                    nama: title.getAt(i),
                                                  ),
                                              transition: Transition.downToUp);
                                        },
                                        onDoubleTap: () {
                                        },
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )))
                : Container(
                    color: Const.bgcolor,
                    child: Center(
                      child: Text("No Bookmark",
                          style: GoogleFonts.chakraPetch(
                              textStyle: TextStyle(fontSize: 20))),
                    ),
                  ))
        : Container();
  }
}
