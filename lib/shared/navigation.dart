import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/widgets/navigation_item.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 350,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 63),
            child: Container(
              height: 103,
              width: 103,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/login/logo.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Vendeco",
              style: GoogleFonts.aladin(
                fontSize: 50,
                color: const Color(0xFF002E2C),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 63.0),
            child: SizedBox(
              height: 306,
              width: 460,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const NavigationItem(
                    title: "Dashboard",
                    icon: Icons.dashboard,
                  ),
                  const NavigationItem(
                    title: "Transactions",
                    icon: Icons.transcribe,
                  ),
                  const NavigationItem(
                    title: "Sales Summary",
                    icon: Icons.sell,
                  ),
                  const NavigationItem(
                    title: "Logout",
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
