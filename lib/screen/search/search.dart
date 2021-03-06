import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/search/hasilcari.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var myController = TextEditingController();
  bool typing = false;
  int state = 0;

  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: Cari(
                        query: myController.text,
                      )));
                },
              ),
            ),
          ]),
      body: Center(
        child: Text("Apa Cari Kak"),
      ),
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
