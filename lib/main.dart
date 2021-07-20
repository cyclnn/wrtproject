import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/cek_update.dart';
import 'package:wrtproject/mesin/const.dart';
import 'package:wrtproject/screen/bloc/modebaca_bloc.dart';
import 'package:wrtproject/screen/bloc/setting_bloc.dart';
import 'package:wrtproject/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wrtproject/mesin/auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'mesin/global.dart' as globals;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> initPlatformState() async {
  MobileAds.instance.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var perm;
  if (prefs.getInt("readmode") == null) {
    prefs.setInt("readmode", 1);
  }

  dynamic legt2;
  CollectionReference data = FirebaseFirestore.instance.collection("Server");
  await data.doc("Ads").get().then<dynamic>((DocumentSnapshot value) async {
    legt2 = value.data();
  });
  

  prefs.setInt("Ads1", legt2['home']);
  prefs.setInt("Ads2", legt2['chapter']);
  prefs.setInt("Ads3", legt2['listpage']);

  OneSignal.shared.setAppId("be7dac02-14fd-470f-bf7d-5ba24e08bdd2");

  OneSignal.shared.setNotificationOpenedHandler((openedResult) {
    var data = openedResult.notification.additionalData;

    globals.appNavigator.currentState.push(MaterialPageRoute(
        builder: (context) => Tes(
              postId: data['post_id'],
            )));
  });
  (prefs.getBool("notif") == null)
      ? perm = false
      : perm = prefs.getBool("notif");

  OneSignal.shared.disablePush(perm);
}

Future<void> main() async {
  globals.appNavigator = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Hive.initFlutter();
  await Hive.openBox('title');
  await Hive.openBox('gambar');
  await Hive.openBox('url');
  await Hive.openBox('idbookmark');

  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "habib";
  String content = "torang";

  @override
  void initState() {
    super.initState();
    main();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Const.baseColor);

    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (_, snapshot) => StreamProvider.value(
            value: AuthServices.firebaseUserStream,
            initialData: null,
            child: MultiBlocProvider(
                providers: [
                  BlocProvider<ColorBloc>(
                    create: (_) => ColorBloc(),
                  ),
                  BlocProvider<ColorBloc2>(
                    create: (_) => ColorBloc2(),
                  ),
                  BlocProvider<ModeBloc>(
                    create: (_) => ModeBloc(),
                  ),
                  BlocProvider<ModeBloc2>(
                    create: (_) => ModeBloc2(),
                  ),
                  BlocProvider<ModeBloc3>(
                    create: (_) => ModeBloc3(),
                  )
                ],
                child: GetMaterialApp(
                  builder: (context, widget) => ResponsiveWrapper.builder(
                    BouncingScrollWrapper.builder(context, widget),
                    maxWidth: 1200,
                    minWidth: 480,
                    defaultScale: true,
                    breakpoints: [
                      ResponsiveBreakpoint.resize(480, name: MOBILE),
                      ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      ResponsiveBreakpoint.resize(1000, name: DESKTOP)
                    ],
                  ),
                  title: "WRT",
                  debugShowCheckedModeBanner: false,
                  home: DoubleBack(
                      message: "Press back again to close",
                      child: (snapshot.hasData) ? Wrapper() : error()),
                ))));
  }
}

error() {
  return Scaffold(
    backgroundColor: Const.bgcolor,
    body: Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Checking Connection...",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(
          color: Const.text,
          strokeWidth: 1,
        )
      ],
    )),
  );
}
