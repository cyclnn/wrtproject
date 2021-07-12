import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static CollectionReference koleksi =
      FirebaseFirestore.instance.collection(auth.currentUser.email);

  static Future<void> createOrupdate(String id,
      {String nama, String link, String img}) async {
    await koleksi.doc(id).set({
      'nama': nama,
      'link': link,
      'img': img,
    });
  }

  static Future<void> delete(String id,
      {String nama, String link, String img}) async {
    await koleksi.doc(id).set({
      'nama': nama,
      'link': link,
      'img': img,
    });
  }

  static Future<DocumentSnapshot> getData(String id) async {
    return await koleksi.doc(id).get();
  }

  static Future<DocumentSnapshot> getIsi(String id) async {
    return await koleksi.doc().get();
  }
}

class Daftar {
  static Future<void> createOrupdate(String email, {String jenis}) async {
    CollectionReference koleksi = FirebaseFirestore.instance.collection(email);
    await koleksi.doc('jenis').set({
      'akun': jenis,
    });
  }
}
