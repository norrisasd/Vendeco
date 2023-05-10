// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/sales_summary/models/sales.dart';
import 'package:vendeco/shared/constants.dart';
import '../../../../auth.dart';
import '../../../../shared/responsive.dart';
import '../../../../shared/widgets/mobile_header.dart';
import '../../transactions/controllers/DropDown_controller.dart';
import '../../transactions/models/months.dart';
import '../../transactions/views/components/transactions.dart';
import '../models/total_sales.dart';
import 'components/bar_chart.dart';
import 'package:collection/collection.dart';
import 'components/total_sales_table.dart';

class SalesSummaryContent extends StatelessWidget {
  const SalesSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    double overAllTotal = 0;
    final Size size = MediaQuery.of(context).size;
    double sizeW = MediaQuery.of(context).size.width;
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
            if (sizeW <= 1480)
              const Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: MobileHeader(color: primaryColor),
              ),
            Text(
              currentYear.toString(),
              style: GoogleFonts.akshar(
                height: 1,
                fontSize: Responsive.isMobile(context) ? 130 : 150,
                fontWeight: fwSemiBold,
                color: primaryColor,
                letterSpacing: Responsive.isMobile(context) ? 13 : 15,
              ),
            ),
            Text(
              "total sales",
              style: GoogleFonts.akshar(
                height: 0.7,
                fontSize: Responsive.isMobile(context) ? 50 : 70,
                fontWeight: fwSemiBold,
                color: const Color(0xFFA9BAAE),
                letterSpacing: Responsive.isMobile(context) ? 5 : 7,
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

                    if (currentMonthForSales == currentYear.toString()) {
                      double totalShampooSales = 0;
                      double totalHairConditionerSales = 0;
                      double totalFabricConditionerSales = 0;
                      double totalLiquidDetergentSales = 0;
                      for (int i = 0; i < totalSales.length; i++) {
                        totalShampooSales += totalSales[i].shampoo!;
                        totalHairConditionerSales +=
                            totalSales[i].hairConditioner!;
                        totalFabricConditionerSales +=
                            totalSales[i].fabricConditioner!;
                        totalLiquidDetergentSales +=
                            totalSales[i].liquidDetergent!;
                      }

                      finalSales = [
                        Sales(title: "Shampoo", total: totalShampooSales),
                        Sales(
                            title: "Hair Conditioner",
                            total: totalHairConditionerSales),
                        Sales(
                            title: "Liquid Detergent",
                            total: totalLiquidDetergentSales),
                        Sales(
                            title: "Fabric Conditioner",
                            total: totalFabricConditionerSales),
                      ];
                    }
                    overAllTotal = finalSales.fold(
                        0.0, (sum, sale) => sum + (sale.total ?? 0));

                    // int counter = 0;
                    return Container(
                      height: Responsive.isDesktop(context) ? 580 : 1180,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: !Responsive.isDesktop(context)
                          ? Column(
                              children: SalesContentList(
                                  context,
                                  totalSales,
                                  size,
                                  currentMonthForSales,
                                  overAllTotal,
                                  finalSales))
                          : Row(
                              children: SalesContentList(
                                  context,
                                  totalSales,
                                  size,
                                  currentMonthForSales,
                                  overAllTotal,
                                  finalSales),
                            ),
                    );
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

  List<Widget> SalesContentList(
      BuildContext context,
      List<TotalSales> totalSales,
      Size size,
      String currentMonthForSales,
      double overAllTotal,
      List<Sales> finalSales) {
    return [
      Flexible(
        flex: !Responsive.isDesktop(context) ? 1 : 2,
        child: TotalSalesTable(
          totalSales: totalSales,
        ),
      ),
      !Responsive.isDesktop(context)
          ? SizedBox(height: size.height * 0.034)
          : SizedBox(),
      Flexible(
        flex: 1,
        child: TotalSalesChart(
          size: size,
          currentMonthForSales: currentMonthForSales,
          overAllTotal: overAllTotal,
          finalSales: finalSales,
        ),
      )
    ];
  }

  List<TotalSales> getTotalSalesForAllMonths(
      List<VendecoTransaction> initTransactions) {
    List<TotalSales> totalSales = months.map(
      (month) {
        List<VendecoTransaction> transactions =
            filterTransactionByMonth(month, initTransactions);
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

        return TotalSales(
          month: month,
          shampoo: finalSales[0].total,
          hairConditioner: finalSales[1].total,
          liquidDetergent: finalSales[2].total,
          fabricConditioner: finalSales[3].total,
        );
      },
    ).toList();

    return totalSales;
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
    DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ssa');
    DateTime dateTime = format.parse(date);
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
