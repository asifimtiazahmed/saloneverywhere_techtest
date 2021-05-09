import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ),
        Text(
          'OR',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
