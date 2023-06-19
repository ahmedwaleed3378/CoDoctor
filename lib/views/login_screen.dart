import 'package:flutter/material.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/Doctor/doc_home_page.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_project/views/patient_homepage.dart';

import 'package:flutter_project/views/patient_registeration_screen.dart';
import 'package:flutter_project/views/rseset_password_screen.dart';
import 'package:provider/provider.dart';

import '../models/api_requests.dart';
import 'Doctor/doc_registeration.dart';
import 'custom_widgets/forms_button_style.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isDoc;
  bool isLoading = false;
  String? userToken;

  Map<String, dynamic> data = {};

  getDoc(String docId) async {}

  login(String email, String pass, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> res = await Api().post(
        url: '$baseUrl/user/auth/login',
        body: {'email': email, 'password': password});
    print(res['statusCode']);
    if (res['statusCode'] == 200) {
      userToken = res['token'];
      User user = User.fromjson(res['user']);

      if (user.role == 'doctor') {
        print(user.id);
        Map<String, dynamic> resDocData = await Api()
            .getMap(url: '$baseUrl/doctors/${user.id}', name: 'doctor');
        Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor =
            Doctor.fromjson2(resDocData);
        Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor.token =
            userToken;
        print('\n$userToken \n');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorHomePage(),
            ));
      }
      if (user.role == 'patient') {
        print(user.id);
        Map<String, dynamic> resDocData = await Api().getMap(
            url: '$baseUrl/patients/profile/${user.id}', name: 'patient');
        // jj
        Provider.of<CoDoctorProvider>(context, listen: false).registeredPatient =
            Patient.fromjson(resDocData);
        Provider.of<CoDoctorProvider>(context, listen: false)
            .registeredPatient
            .patientToken = userToken;
        print(userToken);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PatientHomePage(),
            ));
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  String email = '';

  String password = '';

  String confirm = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Styles.logo(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                          validator: (value) {
                            return Styles().fieldsValidation(value);
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: Styles().fieldsDecoration(
                              'example@gmail.com',
                              'Enter Your Email Address Please')),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                          validator: (value) {
                            return Styles().fieldsValidation(value);
                          },
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration:
                              Styles().fieldsDecoration('******', 'Password')),
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          await login(email, password, context);
                          FocusScope.of(context).unfocus();

                          // Provider.of<FormProvider>(context,listen: false).docRegistered =
                          //     Doctor.fromjson(data);
                          // print(
                          //     Provider.of<FormProvider>(context,listen: false).docRegistered.id);
                          // Navigator.pushReplacement(context, MaterialPageRoute(
                          //   builder: (context) {
                          //     return const HomeScreen();
                          //   },
                          // ));
                        }
                      },
                      child: isLoading
                          ? Center(
                              child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: const CircularProgressIndicator()),
                            )
                          : const FormsButton(buttonText: 'Login'),
                    ),
                    
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                      ),
                    ),
                 
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'If you don\'t have an account',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600),
                          ), const SizedBox(
                            width: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>const RegisterScreen(),
                                        ));
                                  },
                                  child: const Text(
                                    'Sign Up Now',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Styles.themeColor),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>const DocRegisterScreen(),
                                        ));
                                  },
                                  child: const Text(
                                    'Sign Up as a Doctor',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Styles.themeColor),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
