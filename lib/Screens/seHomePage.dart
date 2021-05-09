import 'package:flutter/material.dart';

import '../Widgets/cardInput.dart';
import 'package:google_fonts/google_fonts.dart';

class SEHomePage extends StatelessWidget {
  final List<String> userRegistrationData = [
    'email',
    'password',
    'firstName',
    'lastName',
    'country',
    'postalCode',
    'phoneNumber'
  ];
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController firstNameText = TextEditingController();
  final TextEditingController lastNameText = TextEditingController();
  final TextEditingController countryText = TextEditingController();
  final TextEditingController postalCodeText = TextEditingController();
  final TextEditingController phoneNumberText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Join as Guest',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('or ',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),),
            TextButton(
                child: Text ('Join as PRO',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red[800], decoration: TextDecoration.underline),
                  ),),

              onPressed: (){},
            ),
          ],
        ),
        SECardInput(emailText, 'Email', false),
        SECardInput(passwordText, 'Password', true),
        SECardInput(firstNameText, 'First Name', false),
        SECardInput(lastNameText, 'Last Name', false),
        SECardInput(countryText, 'Country', false),
        SECardInput(postalCodeText, 'Postal Code', false),
        SECardInput(phoneNumberText, 'Phone Number', false),
        Align(
          child: Container(
            margin: EdgeInsets.only(top: 8.0),
            width: 200.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[800],
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),),
              ),
              onPressed: () {},
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
