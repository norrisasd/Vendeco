// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../../../../shared/responsive.dart';
import 'item_box.dart';

class AvailableItems extends StatelessWidget {
  const AvailableItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: Responsive.isMobile(context) ? 30 : 49,
        runSpacing: Responsive.isMobile(context) ? 39 : 49,
        children: [
          ItemBox(
            name: "Shampoo",
            svgName: "shampoo",
          ),
          ItemBox(
            name: "Hair Conditioner",
            svgName: "hair_conditioner",
          ),
          ItemBox(
            name: "Liquid Detergent",
            svgName: "liquid_detergent",
          ),
          ItemBox(
            name: "Fabric Conditioner",
            svgName: "fabric_conditioner",
          ),
        ]);
  }
}
