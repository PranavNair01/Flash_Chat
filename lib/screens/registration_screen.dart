import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_buttons.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String email;
  String password;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email',),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password',),
              ),
              SizedBox(
                height: 24.0,
              ),
             RoundedButtons(
               title: 'Register',
               colour: Colors.blueAccent,
               onPressed: () async {
                 setState(() {
                   showSpinner = true;
                 });
                 try {
                   final newUser = await _auth.createUserWithEmailAndPassword(
                       email:
                       email, password: password);
                   if (newUser != null) {
                     Navigator.pushNamed(context, ChatScreen.id);
                   }
                   setState(() {
                     showSpinner = false;
                   });
                 }
                 catch (error){
                   setState(() {
                     showSpinner = false;
                   });
                   Alert(
                     context: context,
                     title: "ALERT",
                     desc: "${error}",
                     image: Image.asset("assets/success.png"),
                   ).show();
                 }
               },
             ),
            ],
          ),
        ),
      ),
    );
  }
}
