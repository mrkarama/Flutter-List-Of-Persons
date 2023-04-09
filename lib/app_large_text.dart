import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  final String text;
  Color color;
  double size;

  AppLargeText(
      {super.key,
      required this.text,
      this.size = 30,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size, color: color, fontWeight: FontWeight.bold));
  }
}
