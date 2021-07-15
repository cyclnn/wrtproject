import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../mesin/const.dart';
import 'package:google_fonts/google_fonts.dart';

class Recent extends StatefulWidget {
  TabController controller;
  Recent(this.controller);

  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  int habib;
  bool loading = false;
  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  bool komikLoad = true;

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return
        // (loading == false) ?
        Center(
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Riwayat Disimpan di Perangkat Anda, Jangan Hapus Data Aplikasi, Untuk Menghapus Riwayat Tekan Dan Tahan Komik",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Const.bgcolor,
                              child: Center(
                                child: Text("Coming Soon Feature",
                                    style: GoogleFonts.chakraPetch(
                                        textStyle: TextStyle(fontSize: 20))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )));
  }
}
