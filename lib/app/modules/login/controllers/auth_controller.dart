import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  //TODO: Implement LoginController
  FirebaseAuth auth = FirebaseAuth.instance;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    final box = GetStorage();
    if (user == null) {
      Get.offAllNamed("/login");
    } else {
      if ((!box.hasData('isLoggedIn') || !box.read('isLoggedIn'))) {
        Get.offAllNamed("/dashboard");
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login(String email, password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
        "Error Login Account",
        "Login Message",
        snackPosition: SnackPosition.TOP,
        titleText: const Text("Error Login Account"),
        messageText: Text(e.toString()),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> logOut() async {
    final box = GetStorage();
    box.remove('isLoggedIn');
    await auth.signOut();
  }

  void increment() => count.value++;
}
