import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
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
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFF335C3F)),
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
            child:
                const Text('Go to Home', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
