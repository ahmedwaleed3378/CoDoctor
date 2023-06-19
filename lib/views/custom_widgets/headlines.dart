import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

class HeadLines extends StatelessWidget {
  const HeadLines({super.key, required this.headLine,  this.fontSize=20,  this.opacity=1.0});
  final String headLine;
  final double fontSize;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal:7),
        child: Text(
          headLine,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: white,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ));
  }
}
