import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    if (!box.hasData('isLoggedIn') || !box.read('isLoggedIn')) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offNamed('/login');
        } else {
          box.write('isLoggedIn', true);
        }
      });
    }
    return null;
  }
}
