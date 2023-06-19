import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_svg/svg.dart';

class PersonType extends StatelessWidget {
  const PersonType({
    super.key,
    required this.assetName,
    required this.width,
    required this.height,
  });
  final String assetName;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22), color: Styles.themeColor),
      width: width,
      height: height,
      child: SvgPicture.asset(
        assetName,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
