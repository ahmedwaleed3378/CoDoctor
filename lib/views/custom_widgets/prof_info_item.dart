import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

class ProfileInfoItem extends StatelessWidget {
  const ProfileInfoItem(
      {super.key,

      required this.width,
      required this.height,
      required this.infoLabel,
      required this.infoValue,});
  final double width;
  final double height;
  final String infoLabel;
  final String infoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.08, vertical: height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            infoLabel,
            style: titleStyle.copyWith(color: white),
          ),
          Text(
            infoValue,
            style: subtitleStyle.copyWith(color: white),
          ),
        ],
      ),
    );
  }
}
