import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vendeco/app/modules/login/controllers/auth_controller.dart';

import '../../../../shared/navigation.dart';
import '../../../../shared/responsive.dart';
import '../controllers/dashboard_controller.dart';
import 'dashboard_content.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (AuthController.instance.auth.currentUser == null) {
      // Get.offNamed('/login');
    }
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
            const Expanded(flex: 3, child: DashboardContent()),
          ],
        ),
      ),
    );
  }
}
