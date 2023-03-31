import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 195,
              width: 195,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/login/logo.png"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Text(
                "Welcome to Vendeco",
                style: GoogleFonts.akshar(fontSize: 40),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 47.0),
              child: InputGroup(
                title: "Component ID",
                input: " ",
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 27.0),
              child: InputGroup(
                title: "Password",
                input: " ",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 44.0),
              child: TextButton(
                onPressed: () {
                  // Add your button press logic here
                  Get.toNamed("/dashboard");
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF335C3F)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(180, 60)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.akshar(fontSize: 35, color: Colors.white),
                ),
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
    return SizedBox(
      width: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.akshar(fontSize: 19)),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
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
                )),
          ),
        ],
      ),
    );
  }
}
