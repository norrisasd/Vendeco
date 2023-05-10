import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/constants.dart';
import '../../models/total_sales.dart';

class TotalSalesTable extends StatelessWidget {
  const TotalSalesTable({
    super.key,
    required this.totalSales,
  });

  final List<TotalSales> totalSales;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          minWidth: 600,
          border: TableBorder.all(width: 1, color: const Color(0xFFA8A1A1)),
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
            (index) => availableTransactionItem(totalSales[index]),
          ),
        ),
      ),
    );
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
}
