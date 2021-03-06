import 'package:flutter/material.dart';
import '../../mesin/const.dart';

loadingScreen(var screensize) {
  
  return Stack(
    children: [
      Container(
          width: double.infinity,
          height: screensize.height,
          decoration: BoxDecoration(color: Const.bgcolor),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Const.text2),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(fontSize: 18, color: Const.text2),
                )
              ],
            ),
          ))
    ],
  );
}
