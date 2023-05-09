// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendeco/shared/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../shared/responsive.dart';

class ItemBox extends StatelessWidget {
  final String name;
  final String svgName;
  const ItemBox({super.key, required this.name, required this.svgName});

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
          ItemHeader(svgName: svgName),
          //ITEM NAME
          Center(
            child: Text(
              name,
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
          "P5 / 12mL",
          style: GoogleFonts.akshar(
            fontSize: Responsive.isMobile(context) ? 16 : 26,
            color: Colors.black,
            letterSpacing: Responsive.isMobile(context) ? 1.6 : 2.6,
          ),
        ),
      ],
    );
  }
}

class ItemHeader extends StatelessWidget {
  final String svgName;
  const ItemHeader({
    super.key,
    required this.svgName,
  });

  @override
  Widget build(BuildContext context) {
    Future openDialog(int id, String name) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            // insetPadding: const EdgeInsets.symmetric(vertical: 200),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Item Name"),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Item Name",
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Px/mL"),
                TextField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: "Px/mL",
                  ),
                ),
                const SizedBox(height: 20),
                const Text("xmL/ms"),
                TextField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    hintText: "xmL/ms",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
            ],
          );
        });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/icons/$svgName.svg",
          color: Colors.black,
          height: !Responsive.isMobile(context) ? 50 : 72,
        ),

        // IconButton(
        //   icon: Icon(
        //     Icons.edit_outlined,
        //     size: Responsive.isMobile(context) ? 22 : 34,
        //     color: const Color(0xFFA8A1A1),
        //   ),
        //   onPressed: () {
        //     openDialog(1, "Fabric Conditioner");
        //   },
        // )
      ],
    );
  }
}
