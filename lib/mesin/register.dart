import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wrtproject/mesin/database.dart';
import 'login.dart';

class Register extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(children: [
        Padding(
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
                    text: 'DAFTAR',
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
                controller: _email,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Email'),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Password'),
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
                        'Daftar',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        try {
                          await auth.createUserWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                        } on FirebaseAuthException catch (e) {
                          Alert(
                                  context: context,
                                  title: "Error",
                                  desc: e.message)
                              .show();
                        }
                        Daftar.createOrupdate(_email.text, jenis: "1")
                            .then((value) => Navigator.pop(context));
                      }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Punya Akun?',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(seconds: 1),
                                    child: LoginScreen()));
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  color: Color.fromRGBO(84, 197, 248, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 300,
                          child: Text(
                            'Jika Tidak ada pesan error berarti registrasi berhasil, disarankan restart aplikasi setelah daftar',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 3,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
