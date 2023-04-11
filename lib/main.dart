import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/dashboard/controllers/TableEditingController.dart';
import 'package:vendeco/app/modules/transactions/controllers/DropDown_controller.dart';

import 'app/modules/dashboard/controllers/MenuAppController.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropDownController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableEditingController(),
        ),
      ],
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
