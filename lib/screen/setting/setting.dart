import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/mesin/auth.dart';
import 'package:wrtproject/mesin/modebaca.dart';
import 'package:wrtproject/mesin/sync_history.dart';
import 'package:wrtproject/screen/bloc/modebaca_bloc.dart';
import 'package:wrtproject/screen/setting/akun_info.dart';
import '../bloc/setting_bloc.dart';
import 'package:get/get.dart';
import 'page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final List<String> url = <String>[
    'https://trakteer.id/WorldRomanceTranslation',
    'https://www.facebook.com/WorldRomanceTranslation',
    'https://discord.com/invite/ktfqKn6',
    'https://wrt.my.id/contact-us/',
    '#',
    '#',
    'https://wrt.my.id/dmca/',
    'https://wrt.my.id/privacy-policy/',
    'https://wrt.my.id/privacy-policy/'
        'https://wrt.my.id/privacy-policy/'
        'https://wrt.my.id/privacy-policy/'
  ];

  final List<String> titl = <String>[
    'About App',
    'Donasi',
    'Facebook',
    'Discord',
    'Contact Us',
    'Copyright',
    'DMCA',
    'Privacy Policy',
    'Help'
  ];
  bool notifi;
  recent(bool isi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notif", isi);
    setState(() {
      notif();
    });
    OneSignal.shared.disablePush(isi);
  }

  void notif() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifi = prefs.getBool("notif");
  }

  void tes() async {
    var cek;
    SharedPreferences mode = await SharedPreferences.getInstance();
    ModeBloc bloc3 = BlocProvider.of<ModeBloc>(context);
    ModeBloc2 bloc4 = BlocProvider.of<ModeBloc2>(context);
    ModeBloc3 bloc5 = BlocProvider.of<ModeBloc3>(context);
    cek = mode.getInt("readmode");
    if (cek == 1) {
      bloc3.add(ColorEvent3.to_transparent);
      bloc4.add(ColorEvent4.to_pink);
      bloc5.add(ColorEvent5.to_transparent);
      setState(() {});
    } else if (cek == 2) {
      bloc3.add(ColorEvent3.to_pink);
      bloc4.add(ColorEvent4.to_transparent);
      bloc5.add(ColorEvent5.to_transparent);
      setState(() {});
    } else if (cek == null) {
      bloc4.add(ColorEvent4.to_transparent);
      bloc3.add(ColorEvent3.to_pink);
      bloc5.add(ColorEvent5.to_pink);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    notif();
    tes();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Size screensize = MediaQuery.of(context).size;
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);
    ColorBloc2 bloc2 = BlocProvider.of<ColorBloc2>(context);
    ModeBloc bloc3 = BlocProvider.of<ModeBloc>(context);
    ModeBloc2 bloc4 = BlocProvider.of<ModeBloc2>(context);
    ModeBloc3 bloc5 = BlocProvider.of<ModeBloc3>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        toolbarHeight: 70,
        backgroundColor: Const.baseColor,
      ),
      body: Container(
        width: double.infinity,
        height: screensize.height,
        decoration: BoxDecoration(color: Const.bgcolor),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Akun",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(
                  height: 8,
                ),
                akunCek(),
                SizedBox(
                  height: 15,
                ),
                jenisAkun(),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Pengaturan",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            builder: (context) {
                              return BlocBuilder<ColorBloc, Color>(
                                builder: (_, color) {
                                  return BlocBuilder<ColorBloc2, Color>(
                                    builder: (_, warna) {
                                      return Container(
                                          color: Colors.black,
                                          child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.notifications,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "Pengaturan Notifikasi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 15,
                                                      color: Colors.white,
                                                    ),
                                                    GestureDetector(
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        width: double.infinity,
                                                        color: warna,
                                                        height: 30,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: Center(
                                                          child: Text(
                                                            "Hidup",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        bloc.add(ColorEvent
                                                            .to_transparent);
                                                        bloc2.add(ColorEvent2
                                                            .to_pink);
                                                        recent(false);
                                                      },
                                                    ),
                                                    GestureDetector(
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 530),
                                                        width: double.infinity,
                                                        color: color,
                                                        height: 30,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: Center(
                                                          child: Text(
                                                            "Mati",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        bloc.add(
                                                            ColorEvent.to_pink);
                                                        bloc2.add(ColorEvent2
                                                            .to_transparent);
                                                        recent(true);
                                                      },
                                                    ),
                                                  ])));
                                    },
                                  );
                                },
                              );
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.3))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(MdiIcons.bellAlert),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Notifikasi",
                                      style: TextStyle(
                                          color: Const.text, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            builder: (context) {
                              return BlocBuilder<ModeBloc, Color>(
                                builder: (_, color) {
                                  return BlocBuilder<ModeBloc2, Color>(
                                    builder: (_, warna) {
                                      return BlocBuilder<ModeBloc3, Color>(
                                        builder: (context, warna2) {
                                          return Container(
                                              color: Colors.black,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons.book,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Text(
                                                                "Mode Halaman Baca",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          height: 15,
                                                          color: Colors.white,
                                                        ),
                                                        GestureDetector(
                                                          child:
                                                              AnimatedContainer(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            width:
                                                                double.infinity,
                                                            color: warna,
                                                            height: 30,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Center(
                                                              child: Text(
                                                                "Native (Default)",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            bloc3.add(ColorEvent3
                                                                .to_transparent);
                                                            bloc4.add(
                                                                ColorEvent4
                                                                    .to_pink);
                                                            bloc5.add(ColorEvent5
                                                                .to_transparent);
                                                            changeReadMode(1);
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child:
                                                              AnimatedContainer(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    530),
                                                            width:
                                                                double.infinity,
                                                            color: color,
                                                            height: 30,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Center(
                                                              child: Text(
                                                                "Webview",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            bloc3.add(
                                                                ColorEvent3
                                                                    .to_pink);
                                                            bloc4.add(ColorEvent4
                                                                .to_transparent);
                                                            bloc5.add(ColorEvent5
                                                                .to_transparent);
                                                            changeReadMode(2);
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child:
                                                              AnimatedContainer(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    530),
                                                            width:
                                                                double.infinity,
                                                            color: warna2,
                                                            height: 30,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Center(
                                                              child: Text(
                                                                "Simpel (Coming Soon)",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            bloc3.add(ColorEvent3
                                                                .to_transparent);
                                                            bloc4.add(ColorEvent4
                                                                .to_transparent);
                                                            bloc5.add(
                                                                ColorEvent5
                                                                    .to_pink);
                                                            changeReadMode(3);
                                                          },
                                                        ),
                                                      ])));
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.3))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(MdiIcons.bookEdit),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Mode Baca",
                                  style: TextStyle(
                                      color: Const.text, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () {
                        var tek =
                            "Fungsi ini akan mencadangkan data bookmark di device anda ke akun yang anda daftarkan, pastikan koneksi anda lancar untuk menghindari error";
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Peringatan",
                          desc: tek,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Oke Siap",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                Syncron.addHistory()
                                    .then((value) => Navigator.pop(context))
                                    .then((value) => alertSuccess());
                              },
                              color: Color.fromRGBO(0, 179, 134, 1.0),
                            ),
                            DialogButton(
                              child: Text(
                                "Sabar Dulu",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(116, 116, 191, 1.0),
                                Color.fromRGBO(52, 138, 199, 1.0)
                              ]),
                            )
                          ],
                        ).show();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.3))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(MdiIcons.syncIcon),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Backup Data",
                                  style: TextStyle(
                                      color: Const.text, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () {
                        var tek =
                            "Fungsi ini akan mengambil data cadangan dari akun anda ke device ini, pastikan koneksi anda lancar untuk menghindari error";
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Peringatan",
                          desc: tek,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Oke Siap",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                await Syncron.restoreHistory()
                                    .then((value) =>
                                        (value == 1) ? tes() : alertFailed())
                                    .then((value) => Get.back())
                                    .then((value) => alertSuccess());
                              },
                              color: Color.fromRGBO(0, 179, 134, 1.0),
                            ),
                            DialogButton(
                              child: Text(
                                "Sabar Dulu",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(116, 116, 191, 1.0),
                                Color.fromRGBO(52, 138, 199, 1.0)
                              ]),
                            )
                          ],
                        ).show();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.3))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(MdiIcons.download),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Restore Data",
                                  style: TextStyle(
                                      color: Const.text, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () async {
                        await DefaultCacheManager().emptyCache();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey, width: 0.3))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(MdiIcons.trashCan),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Clear Cache",
                                  style: TextStyle(
                                      color: Const.text, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                if (auth.currentUser != null)
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: InkWell(
                        onTap: () {
                          AuthServices.signOut();
                          setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.3))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(MdiIcons.logout),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: Const.text, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Info",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Divider(
                  color: Colors.grey,
                ),
                for (var i = 0; i < titl.length; i++)
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: InkWell(
                        onTap: () async {
                          if ((i == 1) || (i == 2) || (i == 3)) {
                            await launch(url[i]);
                          } else {
                            Get.to(
                                () => Hal(jud: titl[i], link: url[i], ang: i));
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.3))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titl[i],
                                style:
                                    TextStyle(color: Const.text, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      )),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey, width: 0.3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Versi",
                          style: TextStyle(color: Const.text, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            Const.version,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertSuccess() {
    return Alert(
      context: context,
      type: AlertType.success,
      title: "Berhasil",
      buttons: [
        DialogButton(
          child: Text(
            "Oke",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Get.back(),
          width: 120,
        )
      ],
    ).show();
  }

  alertFailed() {
    return Alert(
      context: context,
      type: AlertType.error,
      title: "Gagal",
      desc: "Tidak ada data bookmark di akun anda",
      buttons: [
        DialogButton(
          child: Text(
            "Oke",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Get.back(),
          width: 120,
        )
      ],
    ).show();
  }
}
