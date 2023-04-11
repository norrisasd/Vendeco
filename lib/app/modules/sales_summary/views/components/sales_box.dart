import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/constants.dart';
import '../../../../../shared/responsive.dart';
import '../../models/sales.dart';

class SalesBox extends StatelessWidget {
  const SalesBox({
    super.key,
    required this.sales,
  });
  final Sales sales;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
        padding: !Responsive.isMobile(context)
            ? EdgeInsets.symmetric(
                horizontal: _size.width * 0.016,
                vertical: _size.height * 0.031,
              )
            : EdgeInsets.symmetric(
                horizontal: _size.width * 0.016,
                vertical: _size.height * 0.031,
              ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Responsive.isMobile(context))
              AutoSizeText(
                sales.title!,
                textAlign: TextAlign.center,
                style: GoogleFonts.akshar(
                  fontSize: 30,
                  color: secondaryColor,
                  fontWeight: fwSemiBold,
                  letterSpacing: 3.0,
                ),
                maxLines: 2,
              ),
            if (!Responsive.isMobile(context))
              SizedBox(height: _size.height * 0.026),
            Container(
              height: Responsive.isMobile(context) ? 175 : 250,
              width: Responsive.isMobile(context) ? 160 : 250,
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(23),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (Responsive.isMobile(context))
                    SizedBox(
                      width: 130,
                      height: 45,
                      child: AutoSizeText(
                        sales.title!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.akshar(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: fwSemiBold,
                          letterSpacing: 2.3,
                        ),
                      ),
                    ),
                  Center(
                    child: AutoSizeText(
                      sales.total!,
                      style: GoogleFonts.akshar(
                        fontSize: Responsive.isMobile(context) ? 40 : 59,
                        color: Colors.black,
                        fontWeight: fwSemiBold,
                        letterSpacing: Responsive.isMobile(context) ? 4.0 : 5.9,
                      ),
                    ),
                  ),
                  AutoSizeText(
                    "xmL",
                    style: GoogleFonts.akshar(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: fwSemiBold,
                      letterSpacing: 2.3,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
