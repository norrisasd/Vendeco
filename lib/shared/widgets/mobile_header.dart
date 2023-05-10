// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vendeco/shared/constants.dart';

class MobileHeader extends StatelessWidget {
  const MobileHeader({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 32,
              color: color,
            ),
          ),
          Row(
            children: [
              // Icon(
              //   Icons.search,
              //   size: 32,
              //   color: color,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
