// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/transactions/controllers/DropDown_controller.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../shared/responsive.dart';
import '../../../../shared/widgets/mobile_header.dart';
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
        padding: EdgeInsets.symmetric(
          vertical: !Responsive.isMobile(context) ? 50 : 30,
          horizontal: !Responsive.isMobile(context) ? 117 : 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Responsive.isDesktop(context))
              const Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: MobileHeader(color: primaryColor),
              ),
            AutoSizeText(
              "Transactions of the Month of",
              style: GoogleFonts.akshar(
                fontSize: !Responsive.isMobile(context) ? 40 : 22,
                color: primaryColor,
                fontWeight: fwSemiBold,
                letterSpacing: !Responsive.isMobile(context) ? 4.0 : 2.2,
              ),
            ),
            const SizedBox(height: 21),
            Container(
              height: !Responsive.isMobile(context) ? 50 : 25,
              width: !Responsive.isMobile(context) ? 350 : 151,
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
                        fontSize: !Responsive.isMobile(context) ? 27 : 15,
                        color: primaryColor,
                        letterSpacing:
                            !Responsive.isMobile(context) ? 2.7 : 1.5,
                        fontWeight: fwSemiBold,
                      ),
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
                      fontSize: !Responsive.isMobile(context) ? 27 : 15,
                      color: primaryColor,
                      letterSpacing: !Responsive.isMobile(context) ? 2.7 : 1.5,
                      fontWeight: fwLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SvgPicture.asset(
                    "assets/icons/save_as.svg",
                    color: primaryColor,
                    height: !Responsive.isMobile(context) ? 35 : 22,
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
