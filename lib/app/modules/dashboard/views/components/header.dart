import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../../shared/responsive.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Responsive.isDesktop(context))
            AutoSizeText(
              "Hello!\nWelcome back!",
              style: GoogleFonts.akshar(
                fontSize: Responsive.isMobile(context) ? 23 : 45,
                fontWeight: fwBold,
                color: secondaryColor,
                letterSpacing: Responsive.isMobile(context) ? 2.3 : 4.5,
              ),
            ),
          if (!Responsive.isDesktop(context))
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  size: 32,
                  Icons.menu,
                  color: secondaryColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Row(
            children: [
              Container(
                height: Responsive.isMobile(context) ? 32 : 60,
                width: Responsive.isMobile(context)
                    ? constraints.maxWidth * 0.400
                    : constraints.maxWidth * 0.310,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: secondaryColor,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 5 : 20.0,
                    vertical: Responsive.isMobile(context) ? 0 : 14),
                child: const TextField(
                  cursorColor: Colors.black12,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search . . .",
                    counterText: "",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(3),
                  ),
                  maxLength: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Container(
                  height: Responsive.isMobile(context) ? 35 : 57,
                  width: Responsive.isMobile(context) ? 35 : 57,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: secondaryColor,
                  ),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    size: Responsive.isMobile(context) ? 16 : 24,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}
