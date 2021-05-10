import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SETextButton extends StatelessWidget {
  final String text;
  final Function toPress;

  SETextButton({@required this.text, @required this.toPress});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        '$text',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.red[800],
              decoration: TextDecoration.underline),
        ),
      ),
      onPressed: toPress,
    );
  }
}
