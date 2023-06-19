import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

class FormsButton extends StatelessWidget {
 const  FormsButton({
    Key? key,
    required this.buttonText,
    this.buttonColor = prmClr,  this.width=double.infinity - 40,  this.textColor=white,
  }) : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30,top: 10,left: 10,right: 10),
      width: width,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(  
                                              color: darkGreyClr,
                                              blurRadius: 7,
                                              offset: Offset(2, 4),
                                            )
        ],
          borderRadius: BorderRadius.circular(10), color: buttonColor),
      child: Center(
          child: Text(
        buttonText,
        style:  TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontSize: 22),
      )),
    );
  }
}
