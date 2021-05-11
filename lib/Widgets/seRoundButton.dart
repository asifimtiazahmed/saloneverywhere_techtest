import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SERoundButton extends StatelessWidget {
  final double width;
  final String labelText;
  final Function toPress;
  final double textSize;

  SERoundButton(
      {this.width,
      @required this.labelText,
      @required this.toPress,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      width: width ?? 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red[800],
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        onPressed: toPress,
        child: Text(
          '$labelText',
          style: GoogleFonts.poppins(
              //fontWeight: FontWeight.bold,
              fontSize: textSize ?? 25.0,
              color: Colors.white),
        ),
      ),
    );
  }
}
