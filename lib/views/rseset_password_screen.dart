import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_project/views/home_scree.dart';

import '../models/custom_form_field.dart';
import 'custom_widgets/forms_button_style.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  String email = '';

  String password = '';

  bool isLoading = false;

  String confirm = '';
  TextEditingController textEditingController1 = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(12),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Styles.logo(),
                CustomField(
                    labelText: '',
                    hintText: 'E-mail',
                    customController: textEditingController1),
                InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const HomeScreen();
                          },
                        ));
                      }
                    },
                    child:  const FormsButton(buttonText: 'Reset Password')),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Didn\'t recive the email?',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
