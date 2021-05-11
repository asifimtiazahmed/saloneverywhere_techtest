import 'package:flutter/material.dart';
import './Screens/welcomeNewUser.dart';

import './Screens/seHomePage.dart';
import './Screens/signUpVerification.dart';

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
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/signUpVerification') {
          return PageRouteBuilder(
              pageBuilder: (
                _,
                __,
                ___,
              ) =>
                  VerificationPage(
                      loginData: settings.arguments as Map<String, String>),
              transitionsBuilder: (_, __, ___, child) => child);
        }
        if (settings.name == '/dashboard') {
          return PageRouteBuilder(
              pageBuilder: (
                _,
                __,
                ___,
              ) =>
                  WelcomeNewUser(),
              transitionsBuilder: (_, __, ___, child) => child);
        }
        if (settings.name == '/webView') {
          return PageRouteBuilder(
              pageBuilder: (
                _,
                __,
                ___,
              ) =>
                  WelcomeNewUser(),
              transitionsBuilder: (_, __, ___, child) => child);
        }
        return MaterialPageRoute(builder: (_) => SEHomePage());
      },
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
//TODO: Text documentation on the code
