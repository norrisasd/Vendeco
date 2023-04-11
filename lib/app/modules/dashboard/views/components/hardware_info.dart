import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/constants.dart';

class HardwareInfo extends StatelessWidget {
  const HardwareInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        "Component ID!\nLocation of Machine",
        style: GoogleFonts.akshar(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            color: secondaryColor,
            letterSpacing: 4.5),
      ),
    );
  }
}
