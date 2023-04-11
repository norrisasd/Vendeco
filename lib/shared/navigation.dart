import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/widgets/navigation_item.dart';

import 'constants.dart';
import 'responsive.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: height * 0.030),
          if (Responsive.isMobile(context))
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: const EdgeInsets.only(left: 28),
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () => Scaffold.of(context).closeDrawer(),
              ),
            ),
          SizedBox(height: height * 0.050),
          Container(
            // decoration: BoxDecoration(color: Colors.white),
            height: 117,
            width: 117,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/login/logo.png"),
                    fit: BoxFit.fitHeight)),
          ),
          Center(
            //TEXT
            child: AutoSizeText(
              "Vendeco",
              style: GoogleFonts.aladin(
                fontSize: 50,
                color: navItemColor,
              ),
            ),
          ),
          SizedBox(height: height * 0.076),
          const NavigationItem(
            title: "Dashboard",
            svgSrc: "assets/icons/dashboard.svg",
          ),
          SizedBox(height: height * 0.033),
          const NavigationItem(
            title: "Transactions",
            svgSrc: "assets/icons/transactions.svg",
          ),
          SizedBox(height: height * 0.033),
          const NavigationItem(
            title: "Sales-Summary",
            svgSrc: "assets/icons/sales_summary.svg",
          ),
          SizedBox(height: height * 0.033),
          const NavigationItem(
            title: "Logout",
            svgSrc: "assets/icons/logout.svg",
          )
        ],
      ),
    );
  }
}
