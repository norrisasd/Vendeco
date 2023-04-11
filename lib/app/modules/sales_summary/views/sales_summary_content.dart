import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/sales_summary/models/sales.dart';
import 'package:vendeco/shared/constants.dart';
import 'package:vendeco/shared/widgets/mobile_header.dart';

import '../../../../shared/responsive.dart';
import '../../transactions/controllers/DropDown_controller.dart';
import 'components/dropdown_months.dart';
import 'components/sales_box.dart';
import 'components/total_income_box.dart';

class SalesSummaryContent extends StatelessWidget {
  const SalesSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(color: primaryColor),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: !Responsive.isMobile(context) ? 50 : 30,
          vertical: !Responsive.isMobile(context) ? 50 : 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.isDesktop(context) ? 50 : null),
            if (!Responsive.isDesktop(context))
              const Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: MobileHeader(
                  color: secondaryColor,
                ),
              ),
            AutoSizeText(
              "Sales of the Month of",
              style: GoogleFonts.akshar(
                fontSize: !Responsive.isMobile(context) ? 35 : 22,
                color: secondaryColor,
                fontWeight: fwSemiBold,
                letterSpacing: !Responsive.isMobile(context) ? 3.5 : 2.2,
              ),
            ),
            SizedBox(
              height: !Responsive.isMobile(context)
                  ? _size.height * 0.021
                  : _size.height * 0.011,
            ),
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
                      "${context.watch<DropDownController>().currentMonthForSales} 2023",
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
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      height: double.infinity,
                      width: !Responsive.isMobile(context) ? 64 : 30,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: const DropDownMonthForSales(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? _size.height * 0.023
                  : _size.height * 0.056,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(demoSales.length,
                  (index) => SalesBox(sales: demoSales[index])),
            ),
            // SalesBoxGridView(),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? _size.height * 0.020
                  : _size.height * 0.050,
            ),
            TotalIncomeBox(
              sales: Sales(title: "Total Income", total: "P0.00"),
            ),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? _size.height * 0.020
                  : _size.height * 0.050,
            ),
          ],
        ),
      ),
    );
  }
}
