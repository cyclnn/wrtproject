import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wrtproject/mesin/register.dart';
import 'package:wrtproject/screen/Home/home.dart';
import 'package:get/get.dart';
import 'package:wrtproject/wrapper.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      color: Color.fromRGBO(84, 197, 248, 1)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Email'),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Password'),
            ),
            SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Text('Forgot Password?',
                    style: TextStyle(
                        color: Color.fromRGBO(84, 197, 248, 1), fontSize: 18)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 400,
                height: 50,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Color.fromRGBO(84, 197, 248, 1),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    try {
                      auth
                          .signInWithEmailAndPassword(
                              email: _email.text, password: _password.text)
                          .then((value) => Get.to(() => Home(),
                              transition: Transition.downToUp));
                    } on FirebaseAuthException catch (e) {
                      Alert(context: context, title: "Error", desc: e.message)
                          .show();
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                  width: 400,
                  height: 50,
                  child: Container(
                    color: Colors.redAccent,
                    child: new TextButton.icon(
                        onPressed: () {
                          Alert(
                                  context: context,
                                  title: "Ooopss",
                                  desc: "Metode Login Ini Sedang Dikerjakan")
                              .show();
                        },
                        icon: Icon(
                          MdiIcons.google,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Login Google",
                          style: TextStyle(color: Colors.white),
                        )),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Belum Punya Akun?',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => Register());
                        },
                        child: Text('Daftar',
                            style: TextStyle(
                                color: Color.fromRGBO(84, 197, 248, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
