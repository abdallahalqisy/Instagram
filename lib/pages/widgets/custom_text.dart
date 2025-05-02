import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.maxLines = 1,
    this.fontSize = 14,
    this.color = Colors.white,
  });
  final String text;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
