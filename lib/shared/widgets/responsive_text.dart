import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
      {super.key,
      required this.text,
      required this.style,
      required this.fontSize});
  final String text;
  final TextStyle style;
  final int fontSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Text(
        text,
        style: style.copyWith(fontSize: constraints.maxWidth / fontSize),
      );
    });
  }
}
