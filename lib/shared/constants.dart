import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// create a constants that list all the equivalent of font weight with labels and value
const FontWeight fwLight = FontWeight.w300;
const FontWeight fwRegular = FontWeight.w400;
const FontWeight fwMedium = FontWeight.w500;
const FontWeight fwSemiBold = FontWeight.w600;
const FontWeight fwBold = FontWeight.w700;
const Color primaryColor = Color(0xFF335C3F);
const Color secondaryColor = Color(0xFFF5F6F0);
const Color tertiaryColor = Color(0xFFC8C4C4);
const Color navItemColor = Color(0xFF002E2C);

List<Color> selectedNavItemGradient = [
  const Color(0xFFC3DAC1),
  const Color(0xFFC9DEC7).withOpacity(0.58),
  const Color(0xFFC2FFBC).withOpacity(0.1),
];

TextStyle tableText = GoogleFonts.akshar(
  color: Colors.black,
  fontSize: 24,
  fontWeight: fwLight,
  letterSpacing: 2.4,
);
TextStyle transactionTableText = GoogleFonts.akshar(
  color: Colors.black,
  fontSize: 27,
  fontWeight: fwLight,
  letterSpacing: 2.7,
);
