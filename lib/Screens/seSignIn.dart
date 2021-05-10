import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_everywhere_project/Widgets/cardInput.dart';
import 'package:salon_everywhere_project/Widgets/seRoundButton.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              'Sign In',
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
              'Please enter your email address and password to sign in',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black26),
              ),
            ),
          ),
          SECardInput(userEmailController, 'Enter email', false),
          SECardInput(passwordController, 'Password', true),
          SERoundButton(
            labelText: 'Sign in',
            toPress: () {},
          ),
        ],
      ),
    );
  }
}
