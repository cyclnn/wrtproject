import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrtproject/mesin/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../mesin/database.dart';

akunCek() {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: FlatButton.icon(
          onPressed: () {
            Get.to(() => LoginScreen(), transition: Transition.rightToLeft);
          },
          color: Color.fromRGBO(228, 68, 238, 1),
          icon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          label: Text(
            "Login Email",
            style: TextStyle(color: Colors.white),
          )),
    );
  } else if (auth.currentUser != null) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: FlatButton.icon(
          onPressed: () {},
          color: Colors.redAccent,
          icon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          label: Text(
            auth.currentUser.email,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

jenisAkun() {
  FirebaseAuth auth = FirebaseAuth.instance;
  return (auth.currentUser != null)
      ? Padding(
          padding: EdgeInsets.only(left: 8),
          child: FutureBuilder(
            future: Database.getData("jenis"),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Container(
                  height: 35,
                  width: 200,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "Get Data...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              else
                return Container(
                  height: 35,
                  width: 120,
                  color: (snapshot.data['akun'] == "1")
                      ? Colors.green
                      : Colors.orangeAccent,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (snapshot.data['akun'] == "1")
                            ? Text("BETA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                            : Text("PUBLIC",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
            },
          ),
        )
      : SizedBox(
          height: 8,
        );
}
