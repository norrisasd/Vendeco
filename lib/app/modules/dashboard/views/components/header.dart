import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/constants.dart';

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
          AutoSizeText(
            "Hello!\nWelcome back!",
            style: GoogleFonts.akshar(
              fontSize: 48,
              fontWeight: fwBold,
              color: secondaryColor,
              letterSpacing: 4.5,
            ),
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: constraints.maxWidth * 0.310,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        "Search . . .",
                        style: GoogleFonts.akshar(
                          fontSize: 20,
                          color: tertiaryColor,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          height: 25,
                          color: tertiaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Container(
                  height: 57,
                  width: 57,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: secondaryColor,
                  ),
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    size: 24,
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
