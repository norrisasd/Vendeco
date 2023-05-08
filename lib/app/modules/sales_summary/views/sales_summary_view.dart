import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/sales_summary/views/sales_summary_content.dart';

import '../../../../firebase_options.dart';
import '../../../../shared/navigation.dart';
import '../../../../shared/responsive.dart';
import '../../dashboard/controllers/MenuAppController.dart';
import '../controllers/sales_summary_controller.dart';

class SalesSummaryView extends GetView<SalesSummaryController> {
  SalesSummaryView({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Navigation(),
      body: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            return SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // if (Responsive.isMobile(context))
                  //   const Expanded(
                  //     child: SalesSummaryContentMobile(),
                  //   ),
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: Navigation(),
                    ),
                  const Expanded(
                    flex: 3,
                    child: SalesSummaryContent(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
