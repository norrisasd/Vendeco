// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/transactions/controllers/DropDown_controller.dart';
import 'package:vendeco/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:vendeco/shared/constants.dart';

import '../../../../shared/responsive.dart';
import '../../../../shared/widgets/mobile_header.dart';
import 'components/dropdown_months.dart';
import 'components/transaction_table.dart';
import 'components/transactions.dart';

class TransactionsContent extends StatelessWidget {
  const TransactionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        padding: EdgeInsets.symmetric(
          vertical: !Responsive.isMobile(context) ? 50 : 30,
          horizontal: !Responsive.isMobile(context) ? 117 : 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Responsive.isDesktop(context))
              const Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: MobileHeader(color: primaryColor),
              ),
            AutoSizeText(
              "Transactions of the Month of",
              style: GoogleFonts.akshar(
                fontSize: !Responsive.isMobile(context) ? 40 : 22,
                color: primaryColor,
                fontWeight: fwSemiBold,
                letterSpacing: !Responsive.isMobile(context) ? 4.0 : 2.2,
              ),
            ),
            const SizedBox(height: 21),
            Container(
              height: !Responsive.isMobile(context) ? 50 : 25,
              width: !Responsive.isMobile(context) ? 350 : 151,
              decoration: const BoxDecoration(
                color: Color(0xFFD0D0D0),
                borderRadius: BorderRadius.all(Radius.circular(27)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: AutoSizeText(
                      "${context.watch<DropDownController>().currentMonthForTransactions} 2023",
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
                      padding: const EdgeInsets.only(right: 20),
                      child: DropDownMonthForTransactions(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  var transactions = Provider.of<TransactionsController>(
                          context,
                          listen: false)
                      .getTransactionList;
                  final pdfBytes = await generatePdf(transactions);
                  savePdf(pdfBytes, 'transactions.pdf');
                  // exportToExcel(transactions);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      "Save",
                      style: GoogleFonts.akshar(
                        fontSize: !Responsive.isMobile(context) ? 27 : 15,
                        color: primaryColor,
                        letterSpacing:
                            !Responsive.isMobile(context) ? 2.7 : 1.5,
                        fontWeight: fwLight,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SvgPicture.asset(
                      "assets/icons/save_as.svg",
                      color: primaryColor,
                      height: !Responsive.isMobile(context) ? 35 : 22,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TransactionTable(),
            ),
          ],
        ));
  }

  Future<Uint8List> generatePdf(List<VendecoTransaction> data) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final roboto =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
    // create table headers
    final headers = [
      'Date',
      'Product Name',
      'Input Amount',
      'Dispensed mL',
      'Price'
    ];

    // create table data
    final tableData = data.map((transaction) {
      return [
        '${transaction.date}',
        '${transaction.product_name}',
        '${transaction.input_amount}',
        '${transaction.dispensed_mL}',
        '${transaction.price}',
      ];
    }).toList();
    // add table to pdf document
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Table.fromTextArray(
              headers: headers,
              data: tableData,
              headerStyle: pw.TextStyle(font: roboto),
              cellStyle: pw.TextStyle(font: roboto)),
        ],
      ),
    );

    // save the pdf document to bytes
    final bytes = await pdf.save();
    return bytes;
  }

  void savePdf(Uint8List pdfBytes, String fileName) {
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor =
        AnchorElement(href: Url.createObjectUrlFromBlob(Blob([pdfBytes])));
    anchor.download = '$fileName.pdf';
    anchor.click();
    anchor.href = '';
  }
}
