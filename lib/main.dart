import 'package:flutter/material.dart';

import './Screens/seHomePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red[800],
        accentColor: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Image.asset('./Assets/salonLogo.png'),

        ),
        body: SafeArea(
          child: SEHomePage(),
        ),
      ),
    );
  }
}

//TODO: setup up material theming
//TODO: change the TextField to TextFormField and setup validation
//TODD: find a better way to populate user registration fields
//TODO: setup multilingual support
//TODO: setup cognito user auth
//TODO: find out how to upload a pic
//TODO: save that data in SharedPrefs
//TODO: Get an android version release app
//TODO: Get a apple version release app
//TODO: refactor code to seperate widgets and clean code