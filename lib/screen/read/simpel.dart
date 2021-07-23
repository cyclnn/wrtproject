import 'package:flutter/material.dart';
import '../../mesin/const.dart';
import 'package:cached_network_image/cached_network_image.dart';

simpleRead(
  int panjang,
  List<Map<String, dynamic>> url,
  List<Map<String, dynamic>> blogger,
) {
  var img = [];
  String base;
  String imgbased;
  String based;

  var penentu0;
  var penentu;
  var tes;
  var base0;
  print(url[0]['attributes']['src']);
  if (url[0]['attributes']['src'] != null) {
    penentu0 = url[0]['attributes']['src'].toString().split("https://")[1];
    penentu = penentu0.toString().split("/")[0];
    print(penentu);

    if (penentu == "cdn.statically.io") {
      if (url[0]['attributes']['src']
              .toString()
              .split("img/")[1]
              .split("/")[0] ==
          "westmanga") {
        based = "cdn.statically.io";
        base0 = url[0]['attributes']['src']
            .toString()
            .split("westmanga/")[1]
            .split("/")[0];
        base = "/westmanga/$base0/";
        print(base);
        for (var i = 0; i < panjang; i++) {
          imgbased = url[i]['attributes']['src'];
          img.add(imgbased.split(base0)[1].toString());
          print(imgbased.split(base0)[1]);
        }
      }

      if (url[0]['attributes']['src']
              .toString()
              .split("img/")[1]
              .split("/")[0] ==
          "kiryuu") {
        based = "cdn.statically.io";

        for (var i = 0; i < panjang; i++) {
          base0 = url[i]['attributes']['src']
              .toString()
              .split("kiryuu/")[1]
              .split("/")[0];
          base = "kiryuu/$base0";
          print(base);
          imgbased = url[i]['attributes']['src'];
          img.add(imgbased.split(base0)[1].toString());
          print("https://$based/img/$base/f=webp&q=10" + img[i].toString());
        }
      }
      if (tes != "/westmanga/4youscan.xyz/") {
        base = "is3.cloudhost.id";
        based = "cdn.statically.io";
        for (var i = 0; i < panjang; i++) {
          imgbased = url[i]['attributes']['src'];
          img.add(imgbased.split("f=auto")[1]);
        }
      }
    }
    if (penentu == "1.bp.blogspot.com") {
      base = "1.bp.blogspot.com";
      based = "cdn.statically.io";
      for (var i = 0; i < panjang; i++) {
        imgbased = url[i]['attributes']['src'];
        img.add(imgbased.split("1.bp.blogspot.com")[1]);
      }
    } else if (penentu == "img.statically.io") {
      based = "img.statically.io";
      base = "kcast/cdn-image.komikcast.com";
      for (var i = 0; i < panjang; i++) {
        imgbased = url[i]['attributes']['src'];
        img.add(imgbased.split("cdn-image.komikcast.com")[1]);
      }
    } else if (penentu == "images2.imgbox.com") {
      base = "images2.imgbox.com";
      based = "cdn.statically.io";
      for (var i = 0; i < panjang; i++) {
        imgbased = url[i]['attributes']['src'];
        img.add(imgbased.split("imgbox.com")[1]);
      }
    } else if (penentu == "cintakye.files.wordpress.com") {
      base = "cintakye.files.wordpress.com";
      based = "cdn.statically.io";
      for (var i = 0; i < panjang; i++) {
        imgbased = url[i]['attributes']['src'];
        img.add(imgbased.split("cintakye.files.wordpress.com")[1]);
      }
    } else if (penentu == "i0.wp.com" ||
        penentu == "i1.wp.com" ||
        penentu == "i2.wp.com" ||
        penentu == "i3.wp.com") {
      based = "cdn.statically.io";
      if (url[0]['attributes']['src']
              .toString()
              .split("img/")[1]
              .split("/")[0] ==
          "kiryuu") {
        based = "cdn.statically.io";
        base0 = url[0]['attributes']['src']
            .toString()
            .split("kiryuu/")[1]
            .split("/")[0];
        base = "/kiryuu/$base0/";
        print(base0);
        for (var i = 0; i < panjang; i++) {
          imgbased = url[i]['attributes']['src'];
          img.add(imgbased.split(base0)[1]);
        }
      }
      for (var i = 0; i < panjang; i++) {
        imgbased = url[i]['attributes']['src'];
        base = imgbased.split("https://")[1].split("/")[1];
        img.add(imgbased.split(base)[1]);
      }
    }
  } else if (url[0]['attributes']['href'] != null) {
    penentu0 = url[0]['attributes']['href'].toString().split("https://")[1];
    penentu = penentu0.toString().split("/")[0];
    print(penentu);

    if (penentu == "1.bp.blogspot.com") {
      base = "1.bp.blogspot.com";
      based = "cdn.statically.io";
      for (var i = 0; i < panjang; i++) {
        imgbased = url[i]['attributes']['href'];
        img.add(imgbased.split("1.bp.blogspot.com")[1]);
        print("https://$based/img/$base/f=webp&q=10" + img[i].toString());
      }
    }
  } else {
    based = "cdn.statically.io";
    for (var i = 0; i < panjang; i++) {
      base0 = url[i]['attributes']['src']
          .toString()
          .split("https://")[1]
          .split("/")[0];
      base = "/kiryuu/$base0/";
      imgbased = url[i]['attributes']['src'];
      img.add(imgbased.split(base0)[1].toString());
      print(imgbased.split(base0)[1].toString());
    }
  }

  return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: (url != blogger)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < panjang; i++)
                  Container(
                    decoration: BoxDecoration(color: Const.bgcolor),
                    width: double.infinity,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: "https://$based/img/$base/f=webp&q=10" +
                            img[i].toString(),
                        // imageUrl:
                        //     "https://i3.wp.com/$base/" + img[i] + "?quality=20",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Const.text2),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          width: 120,
                          height: 150,
                          child: Center(
                            child: Icon(
                              Icons.error,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < panjang; i++)
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: url[i]['attributes']['href'],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          width: double.infinity,
                          height: 250,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Const.text2),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          width: 120,
                          height: 150,
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: Const.text2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ));
}
