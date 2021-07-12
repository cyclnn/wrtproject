import 'package:flutter/material.dart';
import 'package:wrtproject/screen/about/contact.dart';
import 'package:wrtproject/screen/about/dmca.dart';
import 'package:wrtproject/screen/about/help.dart';
import 'package:wrtproject/screen/about/privacy.dart';
import 'package:wrtproject/screen/about/aboutapp.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Hal extends StatefulWidget {
  final String jud, link;
  final int ang;
  const Hal({Key key, this.jud, this.link, this.ang}) : super(key: key);

  @override
  _HalState createState() => _HalState();
}

class _HalState extends State<Hal> {
  final List<Widget> page = [
    AboutApp(),
    null,
    null,
    null,
    Contact(),
    Dmca(),
    Dmca(),
    Privacy(),
    Help()
  ];

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(228, 68, 238, 1));
    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(228, 68, 238, 1),
        title: Text(widget.jud),
      ),
      body: page[widget.ang],
    );
  }
}
