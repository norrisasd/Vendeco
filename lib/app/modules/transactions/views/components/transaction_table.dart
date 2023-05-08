import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/transactions/controllers/transactions_controller.dart';

import '../../../../../auth.dart';
import '../../../../../shared/constants.dart';
import '../../controllers/DropDown_controller.dart';
import 'transactions.dart';

class TransactionTable extends StatefulWidget {
  const TransactionTable({
    super.key,
  });

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
  late Future<List<VendecoTransaction>> dataFuture;
  int? sortColumnIndex;
  bool isAscending = true;
  List<VendecoTransaction> transactionList = [];
  List<VendecoTransaction> filteredTransactionList = [];

  @override
  void initState() {
    super.initState();
    dataFuture = _getTransactionList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<List<VendecoTransaction>>(
            future: dataFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                String currentMonth = context
                    .watch<DropDownController>()
                    .currentMonthForTransactions;
                transactionList = snapshot.data!;
                filteredTransactionList =
                    filterTransactionByMonth(currentMonth, transactionList);
                context.watch<TransactionsController>().setTransactionList(
                    filteredTransactionList); // set the transaction list
                return Container(
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: const Color(0xFFA8A1A1)),
                  ),
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.dragged)) {
                          return primaryColor; // The color when dragging the scrollbar thumb
                        }
                        return primaryColor; // The default color of the scrollbar thumb
                      }),
                    ),
                    child: transactionDataTable,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
    });
  }

  DataTable2 get transactionDataTable {
    return DataTable2(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      border: TableBorder.all(width: 1, color: const Color(0xFFA8A1A1)),
      minWidth: 600,
      columns: [
        DataColumn(
          onSort: (columnIndex, ascending) {
            onSort(0, ascending);
          },
          label: Center(
            child: AutoSizeText(
              "Date",
              style: transactionTableText,
            ),
          ),
        ),
        DataColumn(
          onSort: (columnIndex, ascending) {
            onSort(1, ascending);
          },
          label: Center(
              child: AutoSizeText(
            "Product Name",
            style: transactionTableText,
          )),
        ),
        DataColumn(
          onSort: (columnIndex, ascending) {
            onSort(2, ascending);
          },
          label: Center(
              child: AutoSizeText(
            "Input Amount",
            style: transactionTableText,
          )),
        ),
        DataColumn(
          onSort: (columnIndex, ascending) {
            onSort(3, ascending);
          },
          label: Center(
              child: AutoSizeText(
            "Dispensed mL",
            style: transactionTableText,
          )),
        ),
        DataColumn(
          onSort: (columnIndex, ascending) {
            onSort(4, ascending);
          },
          label: Center(
              child: AutoSizeText(
            "Price",
            style: transactionTableText,
          )),
        ),
      ],
      rows: List.generate(
        filteredTransactionList.length,
        (index) => availableTransactionItem(filteredTransactionList[index]),
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

  DataRow availableTransactionItem(VendecoTransaction item) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: AutoSizeText(item.date!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.product_name!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.input_amount!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.dispensed_mL!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.price!, style: tableText),
          ),
        ),
      ],
    );
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      transactionList.sort(
          (list1, list2) => compareDate(ascending, list1.date, list2.date));
    } else if (columnIndex == 1) {
      transactionList.sort((list1, list2) =>
          compareString(ascending, list1.product_name, list2.product_name));
    } else if (columnIndex == 2) {
      transactionList.sort((list1, list2) =>
          compareInt(ascending, list1.input_amount, list2.input_amount));
    } else if (columnIndex == 3) {
      transactionList.sort((list1, list2) =>
          compareInt(ascending, list1.dispensed_mL, list2.dispensed_mL));
    } else if (columnIndex == 4) {
      transactionList.sort(
          (list1, list2) => compareInt(ascending, list1.price, list2.price));
    }
    setState(() {
      isAscending = ascending;
      sortColumnIndex = columnIndex;
    });
  }

  int compareString(bool ascending, String? value1, String? value2) =>
      ascending ? value1!.compareTo(value2!) : value2!.compareTo(value1!);
  int compareInt(bool ascending, String? value1, String? value2) {
    int? intValue1 = int.tryParse(value1 ?? '');
    int? intValue2 = int.tryParse(value2 ?? '');
    if (intValue1 == null && intValue2 == null) {
      return 0;
    } else if (intValue1 == null) {
      return ascending ? 1 : -1;
    } else if (intValue2 == null) {
      return ascending ? -1 : 1;
    } else {
      return ascending
          ? intValue1.compareTo(intValue2)
          : intValue2.compareTo(intValue1);
    }
  }

  int compareDate(bool ascending, String? value1, String? value2) {
    final DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ssa');
    final DateTime date1 = format.parse(value1!);
    final DateTime date2 = format.parse(value2!);
    final int comparison = date1.compareTo(date2);
    return ascending ? comparison : -comparison;
  }
}
