import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/responsive.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login_form.dart';
import '../widgets/side_image.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: LoginForm()),
            if (!Responsive.isMobile(context))
              const Expanded(child: SideImage()),
          ],
        ),
      ),
    );
  }
}
