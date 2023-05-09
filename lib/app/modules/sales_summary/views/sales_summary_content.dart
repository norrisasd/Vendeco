// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/sales_summary/models/sales.dart';
import 'package:vendeco/shared/constants.dart';
import '../../../../auth.dart';
import '../../../../shared/responsive.dart';
import '../../transactions/controllers/DropDown_controller.dart';
import '../../transactions/models/months.dart';
import '../../transactions/views/components/transactions.dart';
import '../models/total_sales.dart';
import 'components/dropdown_months.dart';
import 'package:collection/collection.dart';

class SalesSummaryContent extends StatelessWidget {
  const SalesSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    double overAllTotal = 0;
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(color: secondaryColor),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: !Responsive.isMobile(context) ? 50 : 30,
          vertical: !Responsive.isMobile(context) ? 50 : 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              currentYear.toString(),
              style: GoogleFonts.akshar(
                height: 1,
                fontSize: 150,
                fontWeight: fwSemiBold,
                color: primaryColor,
                letterSpacing: 15,
              ),
            ),
            Text(
              "total sales",
              style: GoogleFonts.akshar(
                height: 0.7,
                fontSize: 70,
                fontWeight: fwSemiBold,
                color: const Color(0xFFA9BAAE),
                letterSpacing: 7,
              ),
            ),
            SizedBox(height: size.height * 0.034),
            FutureBuilder(
                future: _getTransactionList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  } else if (snapshot.hasData) {
                    String currentMonthForSales = context
                        .watch<DropDownController>()
                        .currentMonthForSales;
                    List<VendecoTransaction> initTransaction = snapshot.data!;
                    List<VendecoTransaction> transactions =
                        filterTransactionByMonth(
                            currentMonthForSales, initTransaction);
                    var groupedTransactions = groupBy(transactions,
                        (transaction) => transaction.product_name);
                    var totalPriceByProductName = <String, double>{};
                    groupedTransactions.forEach((productName, productList) {
                      var total = productList.fold<double>(
                          0,
                          (sum, transaction) =>
                              sum +
                              double.parse(transaction.input_amount ?? "0"));
                      totalPriceByProductName[productName as String] = total;
                    });

                    List<Sales> finalSales = totalPriceByProductName.entries
                        .map((entry) =>
                            Sales(title: entry.key, total: entry.value))
                        .toList();
                    if (totalPriceByProductName.isEmpty) {
                      finalSales = List.from(demoSales);
                    }
                    List<TotalSales> totalSales =
                        getTotalSalesForAllMonths(initTransaction);
                    // List<TotalSales> totalSales =
                    overAllTotal = finalSales.fold(
                        0.0, (sum, sale) => sum + (sale.total ?? 0));

                    int counter = 0;
                    return Container(
                        height: 580,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFA8A1A1)),
                                ),
                                child: ScrollbarTheme(
                                  data: ScrollbarThemeData(
                                    thumbColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.dragged)) {
                                        return primaryColor; // The color when dragging the scrollbar thumb
                                      }
                                      return primaryColor; // The default color of the scrollbar thumb
                                    }),
                                  ),
                                  child: DataTable2(
                                    border: TableBorder.all(
                                        width: 1,
                                        color: const Color(0xFFA8A1A1)),
                                    columns: [
                                      DataColumn(
                                        label: Center(
                                          child: AutoSizeText(
                                            "Month",
                                            style: transactionTableText,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: AutoSizeText(
                                          "Shampoo",
                                          style: transactionTableText,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: AutoSizeText(
                                          "Hair Conditioner",
                                          style: transactionTableText,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: AutoSizeText(
                                          "Liquid Detergent",
                                          style: transactionTableText,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: AutoSizeText(
                                          "Fabric Conditioner",
                                          style: transactionTableText,
                                        )),
                                      ),
                                    ],
                                    rows: List.generate(
                                      totalSales.length,
                                      (index) => availableTransactionItem(
                                          totalSales[index]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sales For",
                                            style: GoogleFonts.akshar(
                                              fontSize: 26,
                                              fontWeight: fwSemiBold,
                                              color: primaryColor,
                                              letterSpacing: 2.6,
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.01),
                                          Container(
                                            height: 60,
                                            width: size.width * 0.12,
                                            padding: const EdgeInsets.all(8),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFD0D0D0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(27)),
                                            ),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    currentMonthForSales,
                                                    style: GoogleFonts.akshar(
                                                      height: 1,
                                                      fontSize: 25,
                                                      fontWeight: fwSemiBold,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child:
                                                        DropDownMonthForSales()),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: size.height * 0.02),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                            ),
                                            child: BarChart(
                                              BarChartData(
                                                  maxY: overAllTotal / 2,
                                                  minY: 0,
                                                  barTouchData: BarTouchData(
                                                    touchTooltipData:
                                                        BarTouchTooltipData(
                                                      tooltipBgColor:
                                                          primaryColor,
                                                      getTooltipItem: (group,
                                                          groupIndex,
                                                          rod,
                                                          rodIndex) {
                                                        String tooltipText =
                                                            '${rod.toY}';
                                                        TextStyle textStyle =
                                                            GoogleFonts.akshar(
                                                          color: secondaryColor,
                                                          fontWeight:
                                                              fwSemiBold,
                                                          fontSize: 16,
                                                        );
                                                        return BarTooltipItem(
                                                          tooltipText,
                                                          textStyle,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  borderData:
                                                      FlBorderData(show: false),
                                                  gridData:
                                                      FlGridData(show: false),
                                                  titlesData: FlTitlesData(
                                                    show: true,
                                                    topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false)),
                                                    leftTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false)),
                                                    rightTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false)),
                                                    bottomTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget:
                                                            (value, meta) {
                                                          switch (
                                                              value.toInt()) {
                                                            case 0:
                                                              return Text(
                                                                'Shampoo',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              );
                                                            case 1:
                                                              return Text(
                                                                'Hair Cond',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              );
                                                            case 2:
                                                              return Text(
                                                                'Liq Deter',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              );
                                                            case 3:
                                                              return Text(
                                                                'Fab Con',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              );
                                                            default:
                                                              return Text('');
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  barGroups: finalSales
                                                      .map(
                                                        (data) =>
                                                            BarChartGroupData(
                                                          x: counter++,
                                                          barRods: [
                                                            BarChartRodData(
                                                              toY: data.total!,
                                                              width: 70,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                              color: const Color(
                                                                  0xFF577055),
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
                                  )),
                            )
                          ],
                        ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  List<TotalSales> getTotalSalesForAllMonths(
      List<VendecoTransaction> initTransactions) {
    List<TotalSales> totalSales = months.map(
      (months) {
        List<VendecoTransaction> transactions =
            filterTransactionByMonth(months, initTransactions);
        var groupedTransactions =
            groupBy(transactions, (transaction) => transaction.product_name);
        var totalPriceByProductName = <String, double>{};
        groupedTransactions.forEach((productName, productList) {
          var total = productList.fold<double>(
              0,
              (sum, transaction) =>
                  sum + double.parse(transaction.input_amount ?? "0"));
          totalPriceByProductName[productName as String] = total;
        });

        List<Sales> finalSales = totalPriceByProductName.entries
            .map((entry) => Sales(title: entry.key, total: entry.value))
            .toList();
        if (totalPriceByProductName.isEmpty) {
          finalSales = List.from(demoSales);
        }
        return TotalSales(
            month: months,
            shampoo: finalSales[0].total,
            hairConditioner: finalSales[1].total,
            liquidDetergent: finalSales[2].total,
            fabricConditioner: finalSales[3].total);
      },
    ).toList();

    return totalSales;
  }

  DataRow availableTransactionItem(TotalSales item) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: AutoSizeText(item.month!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.shampoo.toString(), style: tableText),
          ),
        ),
        DataCell(
          Center(
            child:
                AutoSizeText(item.hairConditioner.toString(), style: tableText),
          ),
        ),
        DataCell(
          Center(
            child:
                AutoSizeText(item.liquidDetergent.toString(), style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.fabricConditioner.toString(),
                style: tableText),
          ),
        ),
      ],
    );
  }

  List<VendecoTransaction> filterTransactionByMonth(
      String month, List<VendecoTransaction> transactions) {
    List<VendecoTransaction> filteredTransactions = transactions
        .where(
            (transaction) => getMonthName(transaction.date as String) == month)
        .map((transaction) {
      return VendecoTransaction(
        date: transaction.date,
        price: transaction.price,
        input_amount: transaction.input_amount,
        product_name: transaction.product_name,
        dispensed_mL: transaction.dispensed_mL,
      );
    }).toList();
    return filteredTransactions;
  }

  String getMonthName(String date) {
    String dateString = "2023-05-07";
    DateTime dateTime = DateTime.parse(dateString);
    String monthName = DateFormat('MMMM').format(dateTime);
    return monthName;
  }

  Future<List<VendecoTransaction>> _getTransactionList() async {
    final User? user = Auth().currentUser;
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("UsersData")
        .child(user!.uid)
        .child("readings");

    final DatabaseEvent event = await usersRef.once();
    final DataSnapshot snapshot = event.snapshot;
    List<VendecoTransaction> transactions = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> readings = snapshot.value as Map;
      readings.forEach((key, value) {
        transactions.add(VendecoTransaction(
          date: parseDate(key.toString()),
          product_name: value['productName'].toString(),
          dispensed_mL: value['dispensedmL'].toString(),
          input_amount: value['inputAmount'].toString(),
          price: value['mLprice'].toString(),
        ));
      });
    }

    return transactions;
  }

  String parseDate(String dateNTime) {
    DateTime dateTime = DateTime.parse(dateNTime);
    String dateOnly =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;
    // Convert the hour to AM/PM format
    String amPm = (hour < 12) ? "AM" : "PM";
    hour = (hour > 12) ? hour - 12 : hour;

    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');
    String secondString = second.toString().padLeft(2, '0');
    // Print the time in AM/PM format
    String timeOnly = "$hourString:$minuteString:$secondString$amPm";

    return "$dateOnly $timeOnly";
  }
}
