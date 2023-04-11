import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/constants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Center(
            child: Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              minimumSize: MaterialStateProperty.all<Size>(const Size(180, 60)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44),
                ),
              ),
            ),
            onPressed: () {
              Get.toNamed('/login');
            },
            child: Column(
              children: [
                Text(
                  "Height: ${MediaQuery.of(context).size.height}",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Width: ${MediaQuery.of(context).size.width}",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
