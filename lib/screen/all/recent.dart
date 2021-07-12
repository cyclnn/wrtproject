import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  getnilai() async {
    loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    habib = prefs.getInt('nilai');
    print(habib);
    return habib;
  }

  @override
  void initState() {
    super.initState();
    getnilai();
  }

  bool komikLoad = true;

  @override
  Widget build(BuildContext context) {
    return
        // (loading == false) ?
        Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(34, 34, 34, 1),
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'RECENT (BELUM BERFUNGSI)',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  komikLoad
                      ? Wrap(
                          children: [
                            for (var i = 1; i < 10; i++)
                              FutureBuilder(
                                future: History.getData(i),
                                builder: (context, snapshot) {
                                  if (History.getData(i) == null)
                                    return GestureDetector(
                                        child: Container(
                                      height: 35,
                                      width: 200,
                                      color: Colors.red,
                                      child: Center(
                                        child: Text("Get Data..."),
                                      ),
                                    ));
                                  else
                                    return Padding(
                                      padding: EdgeInsets.only(left: 13),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                  snapshot.data['img'],
                                                  fit: BoxFit.fill,
                                                  loadingBuilder: (context,
                                                      child, loadingprogress) {
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
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Container(
                                                  width: 50,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
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
                                              (snapshot.data['img'] != null)
                                                  ? Positioned(
                                                      top: 5,
                                                      left: 5,
                                                      child: Container(
                                                        width: 15,
                                                        height: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "H",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : null
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: 120,
                                            child: Text(
                                              snapshot.data['nama'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          // Container(
                                          //   width: 120,
                                          //   child: Text(
                                          //     chkomik[i]['title'].toString().trim(),
                                          //     style: TextStyle(
                                          //         color: Colors.grey, fontSize: 12),
                                          //     maxLines: 1,
                                          //     overflow: TextOverflow.ellipsis,
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    );
                                },
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurple),
                          )),
                        )
                ],
              ),
            ));
    // : Container(
    //     width: double.infinity,
    //     height: MediaQuery.of(context).size.height,
    //     child: Center(
    //         child: CircularProgressIndicator(
    //       valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
    //     )),
    //   );
  }
}
