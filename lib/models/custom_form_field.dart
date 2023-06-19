import 'package:flutter/material.dart';

import '../views/custom_widgets/styles_textfield.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.customController,
      this.textInputType = TextInputType.text,
      this.obsecurity = false})
      : super(key: key);
  final String labelText;
  final String hintText;
  final TextEditingController customController;
  final TextInputType? textInputType;
  final bool obsecurity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          obscureText: obsecurity,
          controller: customController,
          keyboardType: textInputType,
          // onChanged: (value) {
          //   customController.text = value;
          // },
          onSaved: (newValue) {
            if (newValue != null) {
              customController.text = newValue;
            }
          },
          validator: (value) {
            return Styles().fieldsValidation(value);
          },
          decoration: Styles().fieldsDecoration(hintText, labelText)),
    );
  }
}
