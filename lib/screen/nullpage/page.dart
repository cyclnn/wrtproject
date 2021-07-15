import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/const.dart';

class NullPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No History"),
        backgroundColor: Const.baseColor,
      ),
      body: Center(
        child: Text("No History to Show"),
      ),
    );
  }
}
