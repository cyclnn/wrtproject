import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/mesin/database.dart';
import 'package:wrtproject/mesin/login.dart';
import 'package:wrtproject/mesin/auth.dart';
import 'package:wrtproject/screen/Home/home.dart';
import '../bloc/setting_bloc.dart';
import 'page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final List<String> url = <String>[
    'https://wrt.my.id',
    'https://trakteer.id/WorldRomanceTranslation',
    'https://www.facebook.com/WorldRomanceTranslation',
    'https://discord.com/invite/ktfqKn6',
    'https://wrt.my.id/contact-us/',
    '#',
    'https://wrt.my.id/dmca/',
    'https://wrt.my.id/privacy-policy/',
    'https://wrt.my.id/privacy-policy/'
        'https://wrt.my.id/privacy-policy/'
        'https://wrt.my.id/privacy-policy/'
  ];

  final List<String> titl = <String>[
    'About App',
    'Notifikasi',
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
  }

  void notif() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifi = prefs.getBool("notif");
    print(notifi);
  }

  @override
  void initState() {
    super.initState();
    notif();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Size screensize = MediaQuery.of(context).size;
    ColorBloc bloc = BlocProvider.of<ColorBloc>(context);
    ColorBloc2 bloc2 = BlocProvider.of<ColorBloc2>(context);

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
                if (auth.currentUser == null)
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: FlatButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: LoginScreen(),
                              ));
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
                  ),
                if (auth.currentUser != null)
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: FlatButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: LoginScreen(),
                              ));
                        },
                        color: Colors.redAccent,
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        label: Text(
                          auth.currentUser.email,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                SizedBox(
                  height: 15,
                ),
                (auth.currentUser != null)
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
                                  child: Text("Get Data..."),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                      ),
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
                          if ((i == 2) || (i == 3) || (i == 4)) {
                            await launch(url[i]);
                          } else if (i == 1) {
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
                                                                Icons
                                                                    .notifications,
                                                                color: Colors
                                                                    .white,
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
                                                                "Hidup",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            bloc.add(ColorEvent
                                                                .to_transparent);
                                                            bloc2.add(
                                                                ColorEvent2
                                                                    .to_pink);
                                                            recent(false);
                                                            print(notifi);
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
                                                                "Mati",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            bloc.add(ColorEvent
                                                                .to_pink);
                                                            bloc2.add(ColorEvent2
                                                                .to_transparent);
                                                            recent(true);
                                                            print(notifi);
                                                          },
                                                        ),
                                                      ])));
                                        },
                                      );
                                    },
                                  );
                                });
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child:
                                      Hal(jud: titl[i], link: url[i], ang: i),
                                ));
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
                            Text(
                              "Clear Cache",
                              style: TextStyle(color: Const.text, fontSize: 16),
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
                          AuthServices.signOut().then((value) =>
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: Home())));
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
                                "Log Out",
                                style:
                                    TextStyle(color: Const.text, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppState with ChangeNotifier {
  bool iisBlue = true;
  bool iisBlue2 = false;
  String tul;
  bool get isBlue => iisBlue;
  bool get isBlue2 => iisBlue2;
  set isBlue(bool value) {
    iisBlue = value;
    notifyListeners();
  }

  Color get color => (iisBlue) ? Colors.pinkAccent : Colors.transparent;
  Color get warna => (iisBlue2) ? Colors.pinkAccent : Colors.transparent;
  String get tex {
    if (iisBlue) {
      return tul = "Hidup";
    } else {
      return tul = "Mati";
    }
  }
}
