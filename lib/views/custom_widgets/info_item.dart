import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

class InfoItem extends StatelessWidget {
   InfoItem(
      {super.key,
      required this.icon,
      required this.value,
      required this.label, required this.width});
  final Widget icon;
  final String value;
  final String label;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 100,
    
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
             const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            icon,
            
              Text(
                label,   textAlign: TextAlign.left,
                style: const TextStyle(color: prmClr),
              ),
              Text(
                value,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: prmClr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
