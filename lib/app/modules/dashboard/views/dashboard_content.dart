import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF335C3F),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 56, right: 56, top: 68),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //TOP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello!\nWelcome back!",
                    style: GoogleFonts.akshar(
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF5F6F0),
                        letterSpacing: 4.5),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 310,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xFFF5F6F0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Search . . .",
                                style: GoogleFonts.akshar(
                                  fontSize: 20,
                                  color: const Color(0xFFC8C4C4),
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 2,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 9.0),
                                child: Icon(
                                  Icons.search_outlined,
                                  size: 25,
                                  color: Color(0xFFC8C4C4),
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
                            color: Color(0xFFF5F6F0),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              //MID
              const SizedBox(height: 43),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 207,
                    width: 491,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 41.0, top: 23),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Profile",
                              style: GoogleFonts.akshar(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF002E2C),
                                letterSpacing: 2.8,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "COMPONENT ID HERE",
                                style: GoogleFonts.akshar(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  letterSpacing: 2.5,
                                ),
                              ),
                              Text(
                                "Location of Machine",
                                style: GoogleFonts.akshar(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 207,
                    width: 432,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 41.0, top: 23),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "LCD Message",
                              style: GoogleFonts.akshar(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF002E2C),
                                letterSpacing: 2.8,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 51,
                            width: 304,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: const Color(0xFFF5F6F0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Show current message here",
                                    style: GoogleFonts.akshar(
                                      fontSize: 15,
                                      color: const Color(0xFFC8C4C4),
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
