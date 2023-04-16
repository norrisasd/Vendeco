// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../../shared/responsive.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobile(context) ? 260 : 360,
      width: Responsive.isMobile(context) ? 160 : 250,
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius:
            BorderRadius.circular(Responsive.isMobile(context) ? 20 : 30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ItemHeader(),
          //ITEM NAME
          Center(
            child: Text(
              "Fabric Conditioner",
              textAlign: TextAlign.center,
              style: GoogleFonts.akshar(
                color: Colors.black,
                fontSize: Responsive.isMobile(context) ? 23 : 35,
                fontWeight: fwMedium,
                letterSpacing: Responsive.isMobile(context) ? 2.3 : 3.5,
              ),
            ),
          ),
          const ItemDetails()
        ],
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Px/mL",
          style: GoogleFonts.akshar(
            fontSize: Responsive.isMobile(context) ? 16 : 26,
            color: Colors.black,
            letterSpacing: Responsive.isMobile(context) ? 1.6 : 2.6,
          ),
        ),
        Text(
          "xmL/ms",
          style: GoogleFonts.akshar(
            fontSize: Responsive.isMobile(context) ? 16 : 26,
            color: Colors.black,
            letterSpacing: Responsive.isMobile(context) ? 1.6 : 2.6,
          ),
        ),
        Text(
          "mL left",
          style: GoogleFonts.akshar(
            fontSize: Responsive.isMobile(context) ? 16 : 26,
            color: Colors.black,
            letterSpacing: Responsive.isMobile(context) ? 1.6 : 2.6,
          ),
        )
      ],
    );
  }
}

class ItemHeader extends StatelessWidget {
  const ItemHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.man_outlined,
          size: Responsive.isMobile(context) ? 40 : 62,
          color: Colors.black,
        ),
        Icon(
          Icons.edit_outlined,
          size: Responsive.isMobile(context) ? 22 : 34,
          color: const Color(0xFFA8A1A1),
        )
      ],
    );
  }
}
