import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:vendeco/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vendeco/app/modules/login/controllers/auth_controller.dart';
import 'package:vendeco/app/modules/transactions/controllers/DropDown_controller.dart';
import 'package:vendeco/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:vendeco/firebase_options.dart';
import 'app/modules/dashboard/controllers/MenuAppController.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));
  // DatabaseReference usersRef = FirebaseDatabase.instance
  //     .ref()
  //     .child("UsersData")
  //     .child("dW27uxmJNpXD3PpqjCMjxrFpJzE3")
  //     .child("readings");
  // usersRef.onValue.listen((event) {
  //   if (event.snapshot.value != null) {
  //     Map<dynamic, dynamic> readings = event.snapshot.value as Map;
  //     readings.forEach((key, value) {
  //       print("Timestamp: $key");
  //       print("Container 1 Distance: ${value['container1Distance']}");
  //       print("Container 2 Distance: ${value['container2Distance']}");
  //       print("Container 3 Distance: ${value['container3Distance']}");
  //       print("Container 4 Distance: ${value['container4Distance']}");
  //       print("Dispensed mL: ${value['dispensedmL']}");
  //       print("Input Amount: ${value['inputAmount']}");
  //       print("mL Price: ${value['mLprice']}");
  //       print("Product Name: ${value['productName']}");
  //     });
  //   }
  // });

  // Print the data to the console
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
          create: (context) => TransactionsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
