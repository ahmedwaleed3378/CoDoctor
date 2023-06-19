 import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
 
 

Container patientProfileInfoItem(String title, String value) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: darkGreyClr),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(7),
      child: Row(
        children: [Text(title), const Spacer(), Text(value,style: titleStyle.copyWith(color: darkGreyClr),)],
      ),
    );
  }