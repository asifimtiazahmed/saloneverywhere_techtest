import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../Screens/webView.dart';
import '../Widgets/seRoundButton.dart';
import '../Widgets/orSeperator.dart';

class WelcomeNewUser extends StatefulWidget {
  @override
  _WelcomeNewUserState createState() => _WelcomeNewUserState();
}

class _WelcomeNewUserState extends State<WelcomeNewUser> {
  AuthUser _user;
  var _userAttributes;
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource srcSelect) async {
    final pickedImage = await picker.getImage(source: srcSelect);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image Selected');
      }
    });
  }

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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10),
              child: (_user == null)
                  ? Text('Loading...')
                  : Text(
                      'Welcome, ${_user.username}!',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.red[800]),
                    ),
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Center(
              child: _image == null
                  ? Text('No image Selected')
                  : Image.file(_image),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SERoundButton(
                labelText: 'Camera',
                toPress: () {
                  getImage(ImageSource.camera);
                },
                textSize: 15.0,
                width: 100,
              ),
              SERoundButton(
                labelText: 'Gallery',
                toPress: () {
                  getImage(ImageSource.gallery);
                },
                textSize: 15.0,
                width: 100,
              ),
            ],
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          //   child: SERoundButton(
          //     labelText: 'Upload Profile Pic',
          //     toPress: () {},
          //     width: 300,
          //   ),
          // ),
          OrSeparator(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SERoundButton(
                  width: 280,
                  labelText: 'View Some Profiles',
                  toPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewExplorer()));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
