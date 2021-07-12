import 'package:flutter/material.dart';

class Lapor extends StatefulWidget {
  @override
  _LaporState createState() => _LaporState();
}

class _LaporState extends State<Lapor> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Color.fromRGBO(228, 68, 238, 1),
          title: Text("Lapor Masalah"),
        ),
        body: Container(
          width: double.infinity,
          height: screensize.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("Dibuat karena gabut"),
            ),
          ),
        ));
  }
}
