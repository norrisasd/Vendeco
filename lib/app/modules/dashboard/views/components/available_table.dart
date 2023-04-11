// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/dashboard/controllers/TableEditingController.dart';
import 'package:vendeco/app/modules/dashboard/views/components/available_items.dart';
import 'package:vendeco/shared/constants.dart';

class AvailableTable extends StatefulWidget {
  const AvailableTable({super.key});

  @override
  State<AvailableTable> createState() => _AvailableTable();
}

class _AvailableTable extends State<AvailableTable> {
  @override
  Widget build(BuildContext context) {
    bool isEditing = context.watch<TableEditingController>().isEditing;
    List<AvailableItems> updatedAvailableItems =
        context.watch<TableEditingController>().latestAvailableItems;
    List<AvailableItems> tempAvailableItems =
        context.watch<TableEditingController>().tempAvailableItems;
    return Container(
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
            Radius.circular(23)), // Set background color of DataTable to white
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "Available Items",
                style: GoogleFonts.akshar(
                  fontSize: 33,
                  letterSpacing: 3.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isEditing
                  ? Row(
                      children: [
                        TextButton(
                          //Cancel
                          onPressed: () {
                            setState(() {
                              // updatedAvailableItems =
                              //     List<AvailableItems>.from(tempAvailableItems);
                              context
                                  .read<TableEditingController>()
                                  .controlEditing();
                              if (kDebugMode) {
                                print(tempAvailableItems[0].product_name);
                              }
                            });
                          },
                          child: Icon(
                            Icons.cancel,
                            size: 30,
                            color: Color(0xFFA8A1A1),
                          ),
                        ),
                        TextButton(
                          //SAVE
                          onPressed: () {
                            context
                                .read<TableEditingController>()
                                .updateTable(updatedAvailableItems);
                          },
                          child: SvgPicture.asset(
                            "assets/icons/save_as.svg",
                            height: 30,
                            color: Color(0xFFA8A1A1),
                          ),
                        ),
                      ],
                    )
                  : TextButton(
                      //EDIT
                      onPressed: () {
                        context.read<TableEditingController>().controlEditing();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/edit.svg",
                        height: 30,
                        color: Color(0xFFA8A1A1),
                      ),
                    )
            ],
          ),
          SizedBox(height: 36),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: DataTable2(
                horizontalMargin: 0,
                dataRowHeight: 75,
                columnSpacing: 16,
                minWidth: 600,
                // ignore: prefer_const_literals_to_create_immutables
                columns: [
                  DataColumn(
                    label: Center(
                        child: AutoSizeText('Item',
                            style: tableText.copyWith(fontWeight: fwBold))),
                  ),
                  DataColumn(
                    label: Center(
                        child: AutoSizeText('Product Name',
                            style: tableText.copyWith(fontWeight: fwBold))),
                  ),
                  DataColumn(
                    label: Center(
                        child: AutoSizeText('Price/XML',
                            style: tableText.copyWith(fontWeight: fwBold))),
                  ),
                  DataColumn(
                    label: Center(
                        child: AutoSizeText('Dispense Time',
                            style: tableText.copyWith(fontWeight: fwBold))),
                  ),
                  DataColumn(
                    label: Center(
                        child: AutoSizeText('Quality Left',
                            style: tableText.copyWith(fontWeight: fwBold))),
                  ),
                ],
                rows: updatedAvailableItems
                    .map((item) => availableItemDataRow(item, isEditing))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow availableItemDataRow(AvailableItems item, bool isEditing) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(item.item!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: isEditing
                ? TextField(
                    controller: TextEditingController(text: item.product_name!),
                    onChanged: (newValue) {
                      item.product_name = newValue;
                    },
                  )
                : AutoSizeText(item.product_name!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: isEditing
                ? TextField(
                    controller: TextEditingController(text: item.price!),
                    onChanged: (newValue) {
                      item.price = newValue;
                    },
                  )
                : AutoSizeText(item.price!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: isEditing
                ? TextField(
                    controller:
                        TextEditingController(text: item.dispense_time!),
                    onChanged: (newValue) {
                      item.dispense_time = newValue;
                    },
                  )
                : AutoSizeText(item.dispense_time!, style: tableText),
          ),
        ),
        DataCell(
          Center(
            child: isEditing
                ? TextField(
                    controller: TextEditingController(text: item.quality_left!),
                    onChanged: (newValue) {
                      item.quality_left = newValue;
                    },
                  )
                : AutoSizeText(item.quality_left!, style: tableText),
          ),
        ),
      ],
    );
  }
}
