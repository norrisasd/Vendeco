// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../shared/responsive.dart';
import '../controllers/MenuAppController.dart';
import 'components/available_table.dart';
import 'components/hardware_info.dart';
import 'components/header.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: const BoxDecoration(
          color: primaryColor,
        ),
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //TOP
            if (!Responsive.isDesktop(context))
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: secondaryColor,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            DashboardHeader(),
            //MID
            const SizedBox(height: 43),
            HardwareInfo(),
            const SizedBox(height: 49),
            Expanded(
              child: AvailableTable(),
            )
          ],
        ),
      ),
    );
  }
}
