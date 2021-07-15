import 'package:flutter/material.dart';

class Tes extends StatefulWidget {
  final String postId;

  const Tes({Key key, this.postId}) : super(key: key);

  @override
  _TesState createState() => _TesState();
}

class _TesState extends State<Tes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing"),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(widget.postId),
      ),
    );
  }
}
