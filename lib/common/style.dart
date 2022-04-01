import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFEDA15);

const MaterialColor primarySwatch = MaterialColor(
  0xFFFEDA15,
  <int, Color>{
    50: Color(0xFFfffee6),
    100: Color(0xFFfffac1),
    200: Color(0xFFfef697),
    300: Color(0xFFfdf26a),
    400: Color(0xFFfaed44),
    500: Color(0xFFf7e80e),
    600: Color(0xFFfedb15),
    700: Color(0xFFfec205),
    800: Color(0xFFfea900),
    900: Color(0xFFfd7e00),
  },
);

const Color secondaryColor = Color(0xFFFF9529);

const Color primaryTextColor = Color(0xFF010101);
Color secondaryTextColor = primaryTextColor.withOpacity(0.7);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 43,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.5,
      color: primaryTextColor),
  headline2: GoogleFonts.poppins(
      fontSize: 38,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: primaryTextColor),
  headline3: GoogleFonts.poppins(
      fontSize: 34, fontWeight: FontWeight.w400, color: primaryTextColor),
  headline4: GoogleFonts.poppins(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.25,
      color: primaryTextColor),
  headline5: GoogleFonts.poppins(
      fontSize: 26, fontWeight: FontWeight.w600, color: primaryTextColor),
  headline6: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: primaryTextColor),
  subtitle1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: secondaryTextColor),
  subtitle2: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: secondaryTextColor),
  bodyText1: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
