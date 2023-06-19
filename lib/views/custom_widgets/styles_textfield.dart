import 'package:flutter/material.dart';

class Styles {
  static const Color themeColor = Color.fromARGB(255, 23, 110, 76);
  static MaterialColor themeMaterialColor =
      MaterialColor(1, {1: Colors.teal.shade800});

  fieldsDecoration(String hintString, String errorString) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(color:Colors.white )),
        hintText: hintString,
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(color: Styles.themeColor)),
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



   static Widget logo() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Image.asset(
        'assets/images/Logo.png',
        fit: BoxFit.cover,
      ),
    );
  }
}



