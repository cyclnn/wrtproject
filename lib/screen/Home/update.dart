import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePJ extends StatelessWidget {
  final String komikImg, komikTitle, ch;
  const UpdatePJ({Key key, this.komikImg, this.komikTitle, this.ch})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: 120,
            height: 150,
            child: CachedNetworkImage(
              imageUrl: komikImg,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(
                width: 120,
                height: 150,
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            width: 120,
            child: Text(
              komikTitle,
              style: GoogleFonts.firaSans(
                  textStyle: TextStyle(
                color: Const.text,
                fontWeight: FontWeight.bold,
              )),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: 120,
            child: Text(
              "Chapter " + ch,
              style: TextStyle(color: Const.textsm, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class UpdatePJ2 extends StatelessWidget {
  final String komikImg, komikTitle, ch;
  const UpdatePJ2({Key key, this.komikImg, this.komikTitle, this.ch})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, String> header = {"referer": "https://wrt.my.id"};

    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: 140,
            height: 180,
            child: CachedNetworkImage(
              httpHeaders: header,
              imageUrl: komikImg,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(
                width: Get.width / 3.5,
                height: 150,
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            width: 120,
            child: Text(
              komikTitle,
              style: GoogleFonts.firaSans(
                  textStyle: TextStyle(
                      color: Const.text,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: 120,
            child: Text(
              "Chapter " + ch,
              style: TextStyle(color: Const.textsm, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
