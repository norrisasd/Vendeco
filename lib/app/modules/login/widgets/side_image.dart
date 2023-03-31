import 'package:flutter/material.dart';

class SideImage extends StatelessWidget {
  const SideImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login/side_image.png"),
              fit: BoxFit.fill)),
    );
  }
}
