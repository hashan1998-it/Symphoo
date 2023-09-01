import 'package:flutter/material.dart';

const normal = FontWeight.normal;
const bold = FontWeight.bold;

textStyle(
    {Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
