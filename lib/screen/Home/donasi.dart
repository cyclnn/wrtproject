import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

donasi() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: GestureDetector(
      child: Image.asset(
        "assets/img/tr.png",
        width: double.infinity,
        height: 90,
      ),
      onTap: () async {
        await launch("https://trakteer.id/WorldRomanceTranslation");
      },
    ),
  );
}
