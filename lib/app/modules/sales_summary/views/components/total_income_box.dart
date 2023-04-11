import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/constants.dart';
import '../../models/sales.dart';

class TotalIncomeBox extends StatelessWidget {
  const TotalIncomeBox({
    super.key,
    required this.sales,
  });
  final Sales sales;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 31),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              sales.title!,
              style: GoogleFonts.akshar(
                fontSize: 30,
                color: secondaryColor,
                fontWeight: fwSemiBold,
                letterSpacing: 3.0,
              ),
            ),
            const SizedBox(height: 26),
            Container(
              height: 100,
              width: 500,
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(23),
                ),
              ),
              child: Center(
                child: AutoSizeText(
                  sales.total!,
                  style: GoogleFonts.akshar(
                    fontSize: 59,
                    color: Colors.black,
                    fontWeight: fwSemiBold,
                    letterSpacing: 5.9,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
