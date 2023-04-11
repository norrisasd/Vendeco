import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/sales_summary/models/sales.dart';
import 'package:vendeco/shared/constants.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
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
            AutoSizeText(
              "Sales of the Month of",
              style: GoogleFonts.akshar(
                fontSize: 35,
                color: secondaryColor,
                fontWeight: fwSemiBold,
                letterSpacing: 3.5,
              ),
            ),
            SizedBox(height: _size.height * 0.021),
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
                      "${context.watch<DropDownController>().currentMonthForSales} 2023",
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
                      child: const DropDownMonthForSales(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _size.height * 0.056),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(demoSales.length,
                  (index) => SalesBox(sales: demoSales[index])),
            ),
            // SalesBoxGridView(),
            SizedBox(height: _size.height * 0.050),
            TotalIncomeBox(
              sales: Sales(title: "Total Income", total: "P0.00"),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
