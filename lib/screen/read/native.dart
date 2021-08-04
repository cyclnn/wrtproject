import 'package:flutter/material.dart';
import '../../mesin/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

nativeRead(
  int panjang,
  List<Map<String, dynamic>> url,
  List<Map<String, dynamic>> blogger,
) {
  Map<String, String> header = {"referer": "https://wrt.my.id"};
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
                        httpHeaders: header,
                        imageUrl: url[i]['attributes']['src'],
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
                            child: NutsActivityIndicator(
                                radius: 18,
                                activeColor: Colors.deepPurpleAccent,
                                inactiveColor: Colors.red,
                                tickCount: 11,
                                startRatio: 0.55,
                                animationDuration: Duration(milliseconds: 700),
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
