import 'package:flutter/material.dart';

class SideImage extends StatelessWidget {
  const SideImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/login/side_image.png"), fit: BoxFit.fill),
      ),
    );
  }
}
