import 'package:flutter/material.dart';
import 'package:wrtproject/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wrtproject/mesin/auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  OneSignal.shared.setAppId("be7dac02-14fd-470f-bf7d-5ba24e08bdd2");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.disablePush(prefs.getBool("notif"));
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

    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.firebaseUserStream,
        initialData: null,
        child: MaterialApp(
            title: "WRT", debugShowCheckedModeBanner: false, home: Wrapper()));
  }
}
