import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static CollectionReference koleksi =
      FirebaseFirestore.instance.collection(auth.currentUser.email);

  static Future<void> createOrupdate(int id,
      {String img, String nama, String link}) async {
    await koleksi.doc('history' + id.toString()).set({
      'img': img,
      'nama': nama,
      'link': link,
    });
  }

  static Future<DocumentSnapshot> getData(int id) async {
    return await koleksi.doc('history$id').get();
  }
}
