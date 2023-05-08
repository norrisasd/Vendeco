// ignore_for_file: library_private_types_in_public_api

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/app/modules/login/controllers/auth_controller.dart';
import 'package:vendeco/shared/constants.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem({
    super.key,
    required this.title,
    required this.svgSrc,
  });
  final String title;
  final String svgSrc;

  @override
  _HoverNavigationItemState createState() => _HoverNavigationItemState();
}

class _HoverNavigationItemState extends State<NavigationItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    Future logout() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await AuthController.instance.logOut();
    }

    String currentRoute =
        Get.currentRoute.substring(1, Get.currentRoute.length);
    bool active = currentRoute.contains(widget.title.toLowerCase());
    String displayTitle = widget.title.replaceAll("-", " ");

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
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: selectedNavItemGradient,
                  ),
                )
              : null,
          child: Center(
            child: ListTile(
              hoverColor: active ? Colors.transparent : null,
              contentPadding: const EdgeInsets.only(left: 51),
              leading: SvgPicture.asset(
                widget.svgSrc,
                height: 30,
                color: _hovering && !active ? Colors.greenAccent : navItemColor,
              ),
              title: AutoSizeText(
                displayTitle,
                style: GoogleFonts.akshar(
                    fontSize: 25,
                    color: _hovering && !active
                        ? Colors.greenAccent
                        : navItemColor,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                // Add your button press logic here
                if (widget.title.toLowerCase() == "logout") {
                  logout();
                }
                Get.toNamed("/${widget.title.toLowerCase()}");
              },
            ),
          ),
        ));
  }
}
