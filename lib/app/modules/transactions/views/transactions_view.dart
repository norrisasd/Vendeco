import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/transactions/views/transactions_content.dart';

import '../../../../shared/navigation.dart';
import '../../../../shared/responsive.dart';
import '../../dashboard/controllers/MenuAppController.dart';
import '../../dashboard/views/dashboard_content.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Navigation(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: Navigation(),
              ),
            const Expanded(
              flex: 3,
              child: TransactionsContent(),
            )
          ],
        ),
      ),
    );
  }
}
