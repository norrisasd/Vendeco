import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../shared/constants.dart';
import '../../../../../shared/responsive.dart';
import '../../models/sales.dart';
import 'dropdown_months.dart';

class TotalSalesChart extends StatelessWidget {
  const TotalSalesChart({
    super.key,
    required this.size,
    required this.currentMonthForSales,
    required this.overAllTotal,
    required this.finalSales,
  });

  final Size size;
  final String currentMonthForSales;
  final double overAllTotal;
  final List<Sales> finalSales;

  @override
  Widget build(BuildContext context) {
    if (finalSales.length == 1) {
      finalSales.add(Sales(title: "Hair Conditioner", total: 0));
      finalSales.add(Sales(title: "Liquid Detergent", total: 0));
      finalSales.add(Sales(title: "Fabric Conditioner", total: 0));
    } else if (finalSales.length == 2) {
      finalSales.add(Sales(title: "Liquid Detergent", total: 0));
      finalSales.add(Sales(title: "Fabric Conditioner", total: 0));
    } else if (finalSales.length == 3) {
      finalSales.add(Sales(title: "Fabric Conditioner", total: 0));
    }
    int counter = 0;
    return Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sales For",
                  style: GoogleFonts.akshar(
                    fontSize: Responsive.isMobile(context) ? 20 : 26,
                    fontWeight: fwSemiBold,
                    color: primaryColor,
                    letterSpacing: Responsive.isMobile(context) ? 2 : 2.6,
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                Container(
                  height: Responsive.isMobile(context) ? 40 : 60,
                  width: Responsive.isMobile(context) ? 170 : 200,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD0D0D0),
                    borderRadius: BorderRadius.all(Radius.circular(27)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          currentMonthForSales,
                          style: GoogleFonts.akshar(
                            height: 1,
                            fontSize: Responsive.isMobile(context) ? 19 : 25,
                            fontWeight: fwSemiBold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerRight,
                          child: DropDownMonthForSales()),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Flexible(
              child: Padding(
                padding: Responsive.isDesktop(context)
                    ? const EdgeInsets.only(left: 20.0)
                    : EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: BarChart(
                    BarChartData(
                        maxY: overAllTotal + 5,
                        minY: 0,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: primaryColor,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              String tooltipText = '${rod.toY}';
                              TextStyle textStyle = GoogleFonts.akshar(
                                color: secondaryColor,
                                fontWeight: fwSemiBold,
                                fontSize: 16,
                              );
                              return BarTooltipItem(
                                tooltipText,
                                textStyle,
                              );
                            },
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text(
                                      'Shampoo',
                                      textAlign: TextAlign.center,
                                    );
                                  case 1:
                                    return const Text(
                                      'Hair Cond',
                                      textAlign: TextAlign.center,
                                    );
                                  case 2:
                                    return const Text(
                                      'Liq Deter',
                                      textAlign: TextAlign.center,
                                    );
                                  case 3:
                                    return const Text(
                                      'Fab Con',
                                      textAlign: TextAlign.center,
                                    );
                                  default:
                                    return const Text('');
                                }
                              },
                            ),
                          ),
                        ),
                        barGroups: finalSales
                            .map(
                              (data) => BarChartGroupData(
                                x: counter++,
                                barRods: [
                                  BarChartRodData(
                                    toY: data.total!,
                                    width: 70,
                                    borderRadius: BorderRadius.zero,
                                    color: const Color(0xFF577055),
                                  ),
                                ],
                              ),
                            )
                            .toList()
                        // [

                        // ],
                        ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
