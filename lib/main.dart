import 'package:flutter/material.dart';
import 'package:wrtproject/mesin/const.dart';
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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  var perm;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('title');
  await Hive.openBox('gambar');
  await Hive.openBox('url');
  await Hive.openBox('idbookmark');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  (prefs.getBool("notif") == null)
      ? perm = false
      : perm = prefs.getBool("notif");
  OneSignal.shared.setAppId("be7dac02-14fd-470f-bf7d-5ba24e08bdd2");

  OneSignal.shared.disablePush(perm);
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
