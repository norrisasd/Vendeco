import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/login_form.dart';
import '../widgets/side_image.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Row(
          children: const [
            LoginForm(),
            SideImage(),
          ],
        ),
      ),
    );
  }
}
