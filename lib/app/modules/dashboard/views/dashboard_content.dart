// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../shared/responsive.dart';
import 'components/available_items.dart';
import 'components/hardware_info.dart';
import 'components/header.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 30 : 50,
            vertical: Responsive.isMobile(context) ? 30 : 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //TOP
            DashboardHeader(),
            if (Responsive.isMobile(context))
              SizedBox(height: Responsive.isMobile(context) ? 31 : 43),
            if (!Responsive.isDesktop(context))
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hello!\nWelcome back!",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.akshar(
                    fontSize: Responsive.isMobile(context) ? 23 : 45,
                    fontWeight: fwSemiBold,
                    color: secondaryColor,
                    letterSpacing: Responsive.isMobile(context) ? 2.3 : 4.5,
                  ),
                ),
              ),
            //MID
            SizedBox(height: Responsive.isMobile(context) ? 31 : 43),
            HardwareInfo(),
            SizedBox(height: Responsive.isMobile(context) ? 40 : 49),
            AvailableItems()
          ],
        ),
      ),
    );
  }
}
