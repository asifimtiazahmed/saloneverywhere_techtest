import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SECardInput extends StatelessWidget {

  final TextEditingController controller;
  final String textLabel;
  final bool obscuring;


  SECardInput(this.controller, this.textLabel, this.obscuring);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      height: 50.0,
      child: Card(
        color: Colors.white70,
        child: TextField(
          controller: controller,
          obscureText: obscuring,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '$textLabel',
            labelStyle: GoogleFonts.poppins(),
          ),
        ),
      ),
    );
  }
}
