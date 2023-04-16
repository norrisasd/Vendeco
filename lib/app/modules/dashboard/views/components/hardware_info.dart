import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/constants.dart';
import '../../../../../shared/responsive.dart';

class HardwareInfo extends StatelessWidget {
  const HardwareInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : 35,
        ),
        child: AutoSizeText(
          "Component ID!\nLocation of Machine",
          style: GoogleFonts.akshar(
              fontSize: Responsive.isMobile(context) ? 14 : 45,
              fontWeight: fwLight,
              color: secondaryColor,
              letterSpacing: Responsive.isMobile(context) ? 1.4 : 4.5),
        ),
      ),
    );
  }
}
