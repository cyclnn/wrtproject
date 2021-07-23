import 'package:shared_preferences/shared_preferences.dart';

changeReadMode(int nilai) async {
  SharedPreferences mode = await SharedPreferences.getInstance();

  mode.setInt("readmode", nilai);
  return mode.getInt("readmode");
}

getReadMode() async {
  var hasil;
  SharedPreferences mode = await SharedPreferences.getInstance();

  hasil = mode.getInt("readmode");
  return hasil;
}

cekReadMode() async {
  var cek;
  SharedPreferences mode = await SharedPreferences.getInstance();
  cek = mode.getInt("readmode");
  return cek;
}
