import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/constants.dart';
import 'transactions.dart';

class TransactionTable extends StatelessWidget {
  const TransactionTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFA8A1A1)),
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
            child: DataTable2(
              border: TableBorder.all(width: 1, color: const Color(0xFFA8A1A1)),
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Center(
                    child: AutoSizeText(
                      "Date",
                      style: transactionTableText,
                    ),
                  ),
                ),
                DataColumn(
                  label: Center(
                      child: AutoSizeText(
                    "Product Name",
                    style: transactionTableText,
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: AutoSizeText(
                    "Number of Order/s",
                    style: transactionTableText,
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: AutoSizeText(
                    "Total mL",
                    style: transactionTableText,
                  )),
                ),
                DataColumn(
                  label: Center(
                      child: AutoSizeText(
                    "Price",
                    style: transactionTableText,
                  )),
                ),
              ],
              rows: List.generate(
                demoTransactions.length,
                (index) => availableTransactionItem(demoTransactions[index]),
              ),
            ),
          ),
        ),
      );
    });
  }

  DataRow availableTransactionItem(Transaction item) {
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
            child: AutoSizeText(item.number_of_order!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: AutoSizeText(item.total_ml!, style: tableText),
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
}
