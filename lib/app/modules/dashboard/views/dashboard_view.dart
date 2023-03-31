import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/navigation.dart';
import '../controllers/dashboard_controller.dart';
import 'dashboard_content.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Navigation(),
            const DashboardContent(),
          ],
        ),
      ),
    );
  }
}
