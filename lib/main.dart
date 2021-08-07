import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/pages/splashScreenPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Color(0xffccceda),
          textTheme: TextTheme(
            bodyText1: GoogleFonts.roboto(
                color: Colors.black, fontSize: 26, letterSpacing: 4),
            bodyText2: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
          ).apply(
            bodyColor: Color(0xffccceda),
          ),
        ),
        home: SplashScreen());
  }
}
