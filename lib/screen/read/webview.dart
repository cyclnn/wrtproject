import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WebViewMode extends StatefulWidget {
  final String link;

  const WebViewMode({Key key, this.link}) : super(key: key);

  @override
  _WebViewModeState createState() => _WebViewModeState();
}

class _WebViewModeState extends State<WebViewMode> {
  WebViewController _webViewController;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebView(
        initialUrl: widget.link,
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
          loading(progress);
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _controller.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://wrt.my.id/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          if (request.url.startsWith('https://syndication.exdynsrv.com')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        gestureNavigationEnabled: false,
      ),
      GestureDetector(
        onTap: () {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Gagal Login",
            desc: "dd",
            buttons: [
              DialogButton(
                child: Text(
                  "Oke",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Get.back(),
                width: 120,
              )
            ],
          ).show();
        },
      )
    ]);
  }
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      });
}

loading(int value) {
  return Stack(children: [
    Container(
      child: Center(
        child: Text("Loading ... $value"),
      ),
    ),
  ]);
}
