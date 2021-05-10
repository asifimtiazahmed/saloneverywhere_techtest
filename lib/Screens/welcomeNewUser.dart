import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:salon_everywhere_project/Widgets/seRoundButton.dart';
import '../Widgets/orSeperator.dart';

class WelcomeNewUser extends StatefulWidget {
  @override
  _WelcomeNewUserState createState() => _WelcomeNewUserState();
}

class _WelcomeNewUserState extends State<WelcomeNewUser> {
  AuthUser _user;
  var _userAttributes;

  //String userName = 'Jason Goncalves';
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    await Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Image.asset('./Assets/salonLogo.png'),
        actions: [
          MaterialButton(
            onPressed: () {
              Amplify.Auth.signOut().then((_) {
                Navigator.pushReplacementNamed(context, '/');
              });
            },
            child: Icon(
              Icons.logout,
              color: Colors.red[800],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10),
            child: (_user == null)
                ? Text('Loading...')
                : Text(
                    'Welcome, ${_user.username}!',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.red[800]),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Thank you for creating your account, it is recommended to upload a profile picture now!',
              style: GoogleFonts.poppins(
                //fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: SERoundButton(
              labelText: 'Upload Profile Pic',
              toPress: () {},
              width: 300,
            ),
          ),
          OrSeparator(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SERoundButton(labelText: 'Dashboard', toPress: () {}),
          )
        ],
      ),
    );
  }
}
