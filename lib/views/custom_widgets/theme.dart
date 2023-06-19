import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color white2 = Colors.white54;
const Color prmClr = Color.fromARGB(255, 4, 184, 255);
 Color bgGradient =white.withOpacity(0.8);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
const Color bgClr =  Color.fromRGBO(241, 241, 241, 1);


TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle:const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          letterSpacing: 3,
          color: 
        darkGreyClr));
}

TextStyle get subheadingStyle {
  return GoogleFonts.lato(
    letterSpacing: 3,
      textStyle:const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: 
         darkGreyClr));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle:const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: 
          // Get.isDarkMode ? Colors.white :
           darkGreyClr));
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle:const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          
          overflow: TextOverflow.clip,
          color: 
          // Get.isDarkMode ? Colors.white :
           white));
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
    
      textStyle:const TextStyle(
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.fade,
          fontSize: 14,
          color: 
          // Get.isDarkMode ? Colors.white :
           white));
}

TextStyle get body2Style {
  return GoogleFonts.lato(
      textStyle:const TextStyle(
        overflow: TextOverflow.fade,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: darkGreyClr
          // Get.isDarkMode ? Colors.grey[200] :
           ));
}




 fieldsDecoration(String hintString, String errorString) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(color:Colors.white )),
        hintText: hintString,
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(color: darkGreyClr)),
        fillColor: Colors.white,
        filled: false);
  }

  fieldsValidation(String? value) {
    if (value!.isEmpty) {
      return 'This field cann\'t be empty';
    } else {
      return null;
    }
  }



