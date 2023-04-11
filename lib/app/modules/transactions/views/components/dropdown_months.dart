import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/constants.dart';
import '../../controllers/DropDown_controller.dart';
import '../../models/months.dart';

class DropDownMonthForTransactions extends StatefulWidget {
  const DropDownMonthForTransactions({super.key});

  @override
  State<DropDownMonthForTransactions> createState() =>
      _DropDownMonthForTransactions();
}

class _DropDownMonthForTransactions
    extends State<DropDownMonthForTransactions> {
  String dropdownValue = DateTime.now().month.toString();
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // value: context.watch<DropDownController>().currentMonth,
      isExpanded: true,
      elevation: 16,
      icon: const Icon(Icons.arrow_downward, color: secondaryColor),
      style: const TextStyle(color: primaryColor),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        context.read<DropDownController>().changeMonthForTransactions(value!);
      },
      items: months.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
