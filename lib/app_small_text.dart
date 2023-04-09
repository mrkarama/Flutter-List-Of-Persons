import 'package:flutter/material.dart';

class AppSmallText extends StatelessWidget {
  final String text;
  Color color;
  double size;

  AppSmallText(
      {super.key,
      required this.text,
      this.size = 18,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size, color: color, fontWeight: FontWeight.normal));
  }
}
