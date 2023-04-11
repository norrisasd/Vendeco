// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/transactions/controllers/DropDown_controller.dart';
import 'package:vendeco/app/modules/transactions/models/months.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../shared/responsive.dart';
import '../../dashboard/controllers/MenuAppController.dart';
import 'components/dropdown_months.dart';
import 'components/transaction_table.dart';

class TransactionsContent extends StatelessWidget {
  const TransactionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 117),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Responsive.isDesktop(context))
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: primaryColor,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            AutoSizeText(
              "Transactions of the Month of",
              style: GoogleFonts.akshar(
                fontSize: 40,
                color: primaryColor,
                fontWeight: fwSemiBold,
                letterSpacing: 4.0,
              ),
            ),
            const SizedBox(height: 21),
            Container(
              height: 50,
              width: 350,
              decoration: const BoxDecoration(
                color: Color(0xFFD0D0D0),
                borderRadius: BorderRadius.all(Radius.circular(27)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: AutoSizeText(
                      "${context.watch<DropDownController>().currentMonthForTransactions} 2023",
                      style: GoogleFonts.akshar(
                        fontSize: 27,
                        color: primaryColor,
                        letterSpacing: 2.7,
                        fontWeight: fwSemiBold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      height: double.infinity,
                      width: 64,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropDownMonthForTransactions(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText(
                    "Save As",
                    style: GoogleFonts.akshar(
                      fontSize: 27,
                      color: primaryColor,
                      letterSpacing: 2.7,
                      fontWeight: fwLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SvgPicture.asset(
                    "assets/icons/save_as.svg",
                    color: primaryColor,
                    height: 35,
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TransactionTable(),
            ),
          ],
        ));
  }
}
