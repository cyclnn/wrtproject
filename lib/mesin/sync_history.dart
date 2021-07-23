import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth user = FirebaseAuth.instance;

class Syncron {
  static Future addHistory() async {
    CollectionReference data =
        FirebaseFirestore.instance.collection(user.currentUser.email);
    var legt;
    await Hive.openBox('title');
    await Hive.openBox('gambar');
    await Hive.openBox('url');

    var title = Hive.box('title');
    var url = Hive.box('url');
    var gambar = Hive.box('gambar');
    var id = Hive.box('idbookmark');
    legt = id.length;

    for (var i = 0; i < legt; i++) {
      if (data.doc("history" + i.toString()) != null) {
        data.doc("history" + id.getAt(i).toString()).delete();
      }
      await data.doc("history" + i.toString()).set({
        "img": gambar.getAt(i),
        "link": url.getAt(i),
        "id": id.getAt(i),
        "title": title.getAt(i)
      });
      await data.doc("historylength").set({"length": i});
    }

    saveReadMode();
  }

  static Future<void> saveReadMode() async {
    CollectionReference data =
        FirebaseFirestore.instance.collection(user.currentUser.email);

    SharedPreferences mode = await SharedPreferences.getInstance();

    await data.doc("settings").set({"readmode": mode.getInt("readmode")});
  }

  static Future<void> restoreReadMode() async {
    CollectionReference data =
        FirebaseFirestore.instance.collection(user.currentUser.email);
    SharedPreferences mode = await SharedPreferences.getInstance();

    await data.doc("settings").set({"readmode": mode.getInt("readmode")});
  }

  static Future restoreHistory() async {
    CollectionReference data =
        FirebaseFirestore.instance.collection(user.currentUser.email);
    SharedPreferences mode = await SharedPreferences.getInstance();
    var legt, status;
    dynamic legt2;
    dynamic bookmark;
    dynamic read;

    await Hive.openBox('title');
    await Hive.openBox('gambar');
    await Hive.openBox('url');
    await Hive.openBox('idbookmark');

    var title = Hive.box('title');
    var url = Hive.box('url');
    var gambar = Hive.box('gambar');
    var id = Hive.box('idbookmark');
    legt = id.length;
    await data
        .doc("historylength")
        .get()
        .then<dynamic>((DocumentSnapshot value) async {
      legt2 = value.data();
    });
    for (var j = legt - 1; j >= 0; j--) {
      title.deleteAt(j);
      url.deleteAt(j);
      gambar.deleteAt(j);
      id.deleteAt(j);
    }

    if (legt2 != null) {
      for (var i = 0; i < legt2['length'] + 1; i++) {
        await data
            .doc("history" + i.toString())
            .get()
            .then<dynamic>((DocumentSnapshot value) async {
          bookmark = value.data();
        });

        title.add(bookmark['title']);
        url.add(bookmark['link']);
        gambar.add(bookmark['img']);
        id.put(bookmark['id'], bookmark['id']);
      }
      status = 1;
    } else {
      status = 0;
      return status;
    }

    await data
        .doc("settings")
        .get()
        .then<dynamic>((DocumentSnapshot value) async {
      read = value.data();
    });

    await mode.setInt("readmode", read['readmode']);
    return status;
  }
}
