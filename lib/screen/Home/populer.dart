import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:google_fonts/google_fonts.dart';

class Populer extends StatelessWidget {
  final String komikImg, komikTitle, chhot, star;
  const Populer(
      {Key key, this.komikImg, this.komikTitle, this.chhot, this.star})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8),
        child: Container(
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                width: 150,
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
                  chhot,
                  style: TextStyle(
                    color: Const.textsm,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 120,
                alignment: Alignment.topLeft,
                child: GFRating(
                  size: 15,
                  value: 5.7,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ));
  }
}
