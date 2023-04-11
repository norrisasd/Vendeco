import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/responsive.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 100),
        decoration: BoxDecoration(
          color: Colors.white,
          image: Responsive.isMobile(context)
              ? const DecorationImage(
                  image: AssetImage("assets/login/side_image.png"),
                  fit: BoxFit.fill)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 230,
              width: 230,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/login/logo.png"),
                      fit: BoxFit.fitHeight)),
            ),
            const SizedBox(height: 36),
            AutoSizeText(
              "Welcome to Vendeco!",
              style: GoogleFonts.akshar(fontSize: 41),
            ),
            SizedBox(height: 47),
            const InputGroup(
              title: "Component ID",
              input: " ",
            ),
            SizedBox(height: 27),
            const InputGroup(
              title: "Password",
              input: " ",
            ),
            SizedBox(height: 44),
            TextButton(
              onPressed: () {
                // Add your button press logic here
                Get.toNamed("/dashboard");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(44),
                  ),
                ),
              ),
              child: AutoSizeText(
                'Login',
                style: GoogleFonts.akshar(fontSize: 41, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}

class InputGroup extends StatelessWidget {
  const InputGroup({super.key, required this.title, required this.input});
  final String title;
  final String input;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          title,
          style: GoogleFonts.akshar(fontSize: 19),
        ),
        const SizedBox(height: 5),
        Container(
          constraints: const BoxConstraints(
              minHeight: 50, maxHeight: 60, minWidth: 250, maxWidth: 400),
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            border: Border.all(color: Colors.black87),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              cursorColor: Colors.black12,
              obscureText: (title == "Password") ? true : false,
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(3),
              ),
              maxLength: 20,
            ),
          ),
        ),
      ],
    );
  }
}
