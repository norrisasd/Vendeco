import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/constants.dart';
import '../../../../../shared/responsive.dart';
import '../../../transactions/controllers/DropDown_controller.dart';
import '../../../sales_summary/models/months.dart';

class DropDownMonthForSales extends StatefulWidget {
  const DropDownMonthForSales({super.key});

  @override
  State<DropDownMonthForSales> createState() => _DropDownMonthForSales();
}

class _DropDownMonthForSales extends State<DropDownMonthForSales> {
  String dropdownValue = DateTime.now().month.toString();
  List<String> monthsList = months;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // value: context.watch<DropDownController>().currentMonth,
      isExpanded: true,
      elevation: 16,
      icon: Icon(Icons.arrow_downward,
          size: Responsive.isMobile(context) ? 12 : 30, color: primaryColor),
      style: const TextStyle(color: primaryColor),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        context.read<DropDownController>().changeMonthForSales(value!);
      },
      items: months.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: AutoSizeText(value),
        );
      }).toList(),
    );
  }
}
