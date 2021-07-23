import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mesin/const.dart';
import '../populer.dart';
import '../../detailpage/detail.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

populerCard(
  List<Map<String, dynamic>> hotlist,
  List<Map<String, dynamic>> hotnama,
  List<Map<String, dynamic>> hotch,
  List<Map<String, dynamic>> rating,
  List<Map<String, dynamic>> link,
  int ads,
  int ads2,
) {
  InterstitialAd _interstitialAd;
  if (ads == 1) {
    InterstitialAd.load(
        adUnitId: Const.ins2,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
          },
        ));
  }
  return Container(
    decoration: BoxDecoration(
      color: Const.cardcolor,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    margin: EdgeInsets.only(top: 8),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'TERPOPULER HARI INI',
            style: TextStyle(color: Const.text, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          color: Const.text,
        ),
        Wrap(children: [
          Container(
            height: 240,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < 5; i++)
                  GestureDetector(
                      child: Populer(
                          komikImg: hotlist[i]['attributes']['src'],
                          komikTitle: hotnama[i]['attributes']['title'],
                          chhot: hotch[i]['title'].toString().trim(),
                          rating: double.parse(rating[i]['title'])),
                      onTap: () async {
                        Get.to(
                            () => Detail(
                                  lnk: link[i]['attributes']['href'],
                                  gambar: hotlist[i]['attributes']['src'],
                                  nama: hotnama[i]['attributes']['title'],
                                  urut: i,
                                  ads: ads2,
                                ),
                            transition: Transition.downToUp).then((value) {
                                                      if (ads == 1)  _interstitialAd.show();

                            });
                      })
              ],
            ),
          )
        ]),
      ],
    ),
  );
}
