import 'package:flutter/material.dart';
import '/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(children: [
          //Logo
          Image.asset(
            'assets/logo.png',
            width: 50,
          ),

          //App Name
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Feria virtual',
              style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: backgroundColor),
            ),
          )
        ]),
      ),
    );
  }
}
