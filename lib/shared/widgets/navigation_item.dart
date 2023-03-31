import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  @override
  _HoverNavigationItemState createState() => _HoverNavigationItemState();
}

class _HoverNavigationItemState extends State<NavigationItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    String currentRoute =
        Get.currentRoute.substring(1, Get.currentRoute.length);
    bool active = currentRoute.indexOf(widget.title.toLowerCase()) != -1;
    return MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: Container(
          height: 70,
          width: 300,
          decoration: active
              ? BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFC3DAC1),
                      const Color(0xFFC9DEC7).withOpacity(0.58),
                      const Color(0xFFC2FFBC).withOpacity(0.1)
                    ],
                  ),
                )
              : null,
          child: Center(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 51),
              leading: Icon(
                widget.icon,
                size: 30,
                color: _hovering && !active
                    ? Colors.greenAccent
                    : const Color(0xFF002E2C),
              ),
              title: Text(
                widget.title,
                style: GoogleFonts.akshar(
                    fontSize: 25,
                    color: _hovering && !active
                        ? Colors.greenAccent
                        : const Color(0xFF002E2C),
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                // Add your button press logic here
                Get.toNamed("/${widget.title.toLowerCase()}");
              },
            ),
          ),
        ));
  }
}
