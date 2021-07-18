import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mesin/const.dart';
import '../../detailpage/detail.dart';
import '../update.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

updateCard(
  List<Map<String, dynamic>> komiklist,
  List<Map<String, dynamic>> namalist,
  List<Map<String, dynamic>> chlist,
  List<Map<String, dynamic>> linkup,
  String title,
  int awal,
  int akhir,
  int ads,
  int ads2,
) {
  InterstitialAd _interstitialAd;
  if (ads == 1) {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2816272273438312/9899635930',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
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
            title,
            style: TextStyle(color: Const.text, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          color: Const.text,
        ),
        Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (var i = awal; i < akhir; i++)
                  Column(
                    children: [
                      GestureDetector(
                        child: (constraints.maxWidth > 300 &&
                                constraints.maxWidth < 500)
                            ? UpdatePJ2(
                                komikImg: komiklist[i]['attributes']['src'],
                                komikTitle: namalist[i]['attributes']['title'],
                                ch: chlist[i]['attributes']['title'],
                              )
                            : (constraints.maxWidth > 500 &&
                                    constraints.maxWidth < 1000)
                                ? UpdatePJ(
                                    komikImg: komiklist[i]['attributes']['src'],
                                    komikTitle: namalist[i]['attributes']
                                        ['title'],
                                    ch: chlist[i]['attributes']['title'],
                                  )
                                : UpdatePJ2(
                                    komikImg: komiklist[i]['attributes']['src'],
                                    komikTitle: namalist[i]['attributes']
                                        ['title'],
                                    ch: chlist[i]['attributes']['title'],
                                  ),
                        onTap: () async {
                          if (ads == 1) await _interstitialAd.show();
                          Get.to(
                              () => Detail(
                                  lnk: linkup[i]['attributes']['href'],
                                  ads: ads2,
                                  gambar: komiklist[i]['attributes']['src'],
                                  nama: namalist[i]['attributes']['title']),
                              transition: Transition.downToUp);
                        },
                        onLongPress: () {},
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
