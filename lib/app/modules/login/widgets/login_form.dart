import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../../auth.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/responsive.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future login() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await AuthController.instance
          .login(_emailController.text, _passwordController.text, context);
    }

    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          height: height,
          padding: EdgeInsets.symmetric(vertical: height * 0.1),
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
              SizedBox(height: height * 0.036),
              AutoSizeText(
                "Welcome to Vendeco!",
                style: GoogleFonts.akshar(
                    fontSize: Responsive.isMobile(context) ? 29 : 41),
              ),
              SizedBox(height: height * 0.047),
              InputGroup(
                title: "Email",
                textController: _emailController,
              ),
              SizedBox(height: height * 0.027),
              InputGroup(
                title: "Password",
                textController: _passwordController,
              ),
              SizedBox(height: height * 0.044),
              TextButton(
                onPressed: () {
                  // Add your button press logic here
                  login();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  minimumSize: MaterialStateProperty.all<Size>(Size(
                      Responsive.isMobile(context) ? 120 : 200,
                      Responsive.isMobile(context) ? 35 : 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
                child: AutoSizeText(
                  'Login',
                  style: GoogleFonts.akshar(
                      fontSize: Responsive.isMobile(context) ? 25 : 41,
                      color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}

class InputGroup extends StatelessWidget {
  const InputGroup(
      {super.key, required this.title, required this.textController});
  final String title;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            title,
            style: GoogleFonts.akshar(
                fontSize: Responsive.isMobile(context) ? 14 : 19),
          ),
          const SizedBox(height: 5),
          Container(
            constraints: const BoxConstraints(
                minHeight: 50, maxHeight: 60, minWidth: 250, maxWidth: 400),
            width: Responsive.isMobile(context) ? 250 : 400,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              border: Border.all(color: Colors.black87),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: textController,
                cursorColor: Colors.black12,
                obscureText: (title == "Password") ? true : false,
                decoration: const InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(3),
                ),
                maxLength: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
