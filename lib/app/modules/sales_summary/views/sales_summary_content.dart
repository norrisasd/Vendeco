import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/sales_summary/models/sales.dart';
import 'package:vendeco/shared/constants.dart';
import 'package:vendeco/shared/widgets/mobile_header.dart';

import '../../../../auth.dart';
import '../../../../shared/responsive.dart';
import '../../transactions/controllers/DropDown_controller.dart';
import '../../transactions/views/components/transactions.dart';
import 'components/dropdown_months.dart';
import 'components/sales_box.dart';
import 'components/total_income_box.dart';
import 'package:collection/collection.dart';

class SalesSummaryContent extends StatelessWidget {
  const SalesSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    double overAllTotal = 0;
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
              width: !Responsive.isMobile(context) ? 350 : 200,
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
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
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
            FutureBuilder(
                future: _getTransactionList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                    overAllTotal = finalSales.fold(
                        0.0, (sum, sale) => sum + (sale.total ?? 0));
                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(finalSales.length,
                          (index) => SalesBox(sales: finalSales[index])),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            // SalesBoxGridView(),
            SizedBox(
              height: Responsive.isMobile(context)
                  ? _size.height * 0.020
                  : _size.height * 0.050,
            ),
            FutureBuilder(
                future: _getTransactionList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return TotalIncomeBox(
                      sales: Sales(title: "Total Income", total: overAllTotal),
                    );
                  } else {
                    return const Center(
                      child: Text(""),
                    );
                  }
                }),
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
