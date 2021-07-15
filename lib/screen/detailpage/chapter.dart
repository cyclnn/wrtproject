import 'package:flutter/material.dart';

class Chapter extends StatelessWidget {
  final String chap, timech;
  const Chapter({Key key, this.chap, this.timech}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 5, bottom: 15),
      child: Container(
          height: 25,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chapter " + chap,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  timech,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          )),
    );
  }
}
