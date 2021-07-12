import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UpdatePJ extends StatelessWidget {
  final String komikImg, komikTitle, ch;
  const UpdatePJ({Key key, this.komikImg, this.komikTitle, this.ch})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: 120,
            height: 150,
            child: CachedNetworkImage(
              imageUrl: komikImg,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(
                width: 120,
                height: 150,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
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
              style: TextStyle(color: Colors.white),
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
              style: TextStyle(color: Colors.grey, fontSize: 12),
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
