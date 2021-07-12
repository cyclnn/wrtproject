import 'dart:async';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrtproject/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(228, 68, 238, 1),
        title: Text("Bookmark (Belum Berfungsi)"),
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
                Wrap(
                  children: [
                    for (var i = 0; i < 15; i++)
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
                                width: 120,
                                height: 150,
                                child: Image.network(
                                  "https://i1.wp.com/wrt.my.id/img/cover/2021/02/i323816.jpg",
                                  fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingprogress) {
                                    if (loadingprogress == null) return child;
                                    return Container(
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
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
                                  "Tes",
                                  style: TextStyle(color: Colors.white),
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
                        onTap: () {},
                      )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
