import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:salon_everywhere_project/Widgets/seRoundButton.dart';
import '../Widgets/orSeperator.dart';

class WelcomeNewUser extends StatelessWidget {
  final String userName = 'Jason Goncalves';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
          child: Text(
            'Welcome, $userName!',
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
    );
  }
}
