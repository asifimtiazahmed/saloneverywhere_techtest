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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Image.asset('./Assets/salonLogo.png'),
      ),
      body: Column(
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
                toPress: () {},
              ),
            ],
          ),
          SERoundButton(labelText: 'Verify', toPress: () {})
        ],
      ),
    );
  }
}
