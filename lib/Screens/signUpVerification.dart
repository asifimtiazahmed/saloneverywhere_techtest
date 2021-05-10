import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:salon_everywhere_project/Widgets/seRoundButton.dart';
import 'package:salon_everywhere_project/Widgets/seTextButton.dart';
import '../Widgets/cardInput.dart';

class VerificationPage extends StatefulWidget {
  final Map<String, String> loginData;

  VerificationPage({@required this.loginData});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController verificationCodeController =
      TextEditingController();
  bool _isEnabled =
      false; //For the button to be enabled so that we can send valid data
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationCodeController.addListener(() {
      setState(() {
        _isEnabled = verificationCodeController.text.isNotEmpty;
      });
    });
  }

  void sendVerification(
      BuildContext context, Map<String, String> data, String code) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
          username: data['email'], confirmationCode: code);
      if (res.isSignUpComplete) {
        //Login user
        final user = await Amplify.Auth.signIn(
            username: data['email'], password: data['password']);

        if (user.isSignedIn) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void _resendCode(BuildContext context, Map<String, String> data) async {
    await Amplify.Auth.resendSignUpCode(username: data['email']);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Confirmation code resent. Check your email',
        style: TextStyle(color: Colors.white),
      ),
    ));
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
              child: Icon(
                Icons.home_outlined,
                color: Colors.red[800],
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              })
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Enter Verification Code',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red[800]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'We sent a six digit code to your email. Please enter it below.',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black26),
              ),
            ),
          ),
          SECardInput(verificationCodeController, 'Enter 6 digit code', false),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn\'t receive the code?',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black26),
                ),
              ),
              SETextButton(
                text: 'Re-send',
                toPress: () {
                  _resendCode(context, widget.loginData);
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SERoundButton(
                labelText: 'Verify',
                toPress: _isEnabled
                    ? () {
                        sendVerification(context, widget.loginData,
                            verificationCodeController.text);
                      }
                    : null),
          )
        ],
      ),
    );
  }
}
