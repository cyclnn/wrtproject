import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Chatango extends StatefulWidget {
  @override
  _ChatangoState createState() => _ChatangoState();
}

class _ChatangoState extends State<Chatango> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(228, 68, 238, 1),
          title: Text("Chatango"),
        ),
        body: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "http://wrt2.chatango.com/",
        ));
  }
}
