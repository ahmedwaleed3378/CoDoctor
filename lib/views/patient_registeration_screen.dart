import 'package:flutter/material.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';

import 'package:flutter_project/views/login_screen.dart';
import 'package:flutter_project/views/patient_homepage.dart';
import 'package:provider/provider.dart';

import '../models/api_requests.dart';
import 'custom_widgets/button_shape.dart';
import 'custom_widgets/theme.dart';
import 'size_config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  postPatients(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> res = await Api()
        .post(url: '$baseUrl/patients/signup', body: {
      "email": email,
      "password": password,
      "firstName": firstName,
      "midName": '',
      "lastName": lastName,
      "gender": (type!) ? 'male' : 'female',
      //   "nationalId": nationalID,
    });

    patientToken = res['token'];
    if (patientToken.isNotEmpty) {
      Provider.of<CoDoctorProvider>(context, listen: false).registeredPatient =
          Patient.fromjson(res['patient']);
      Provider.of<CoDoctorProvider>(context, listen: false)
          .registeredPatient
          .patientToken = patientToken;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PatientHomePage(),
          ));
    }

    setState(() {
      isLoading = false;
    });
  }

  String email = '';
  String patientToken = '';

  String password = '';
  bool? _isPatient;
  String phoneNumber = '';
  String gender = '';
  String nationalID = '';
  String address = '';
  Color typeBorder = bgClr;
  bool isLoading = false;
  bool? type;
  String firstName = '';
  String lastName = '';
  String bloodGroup = '';
  String weight = '';
  bool _isRegitered = false;
  String height = '';
  String? uid;
  DateTime? _selectedDate;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgClr,
        appBar: AppBar(
            backgroundColor: bgClr,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Co-Doctor',
              style: headingStyle.copyWith(color: prmClr),
            )),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                top: 17,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Registeration',
                        style: headingStyle.copyWith(color: darkGreyClr)),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your first name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          firstName = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'your first name',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'First Name',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your last name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          lastName = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'your last name',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Last Name',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your email address';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'example@email.com',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Email Address',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please Enter your height';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       height = value;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide.none),
                    //         hintText: '175 cm',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //         labelText: 'Height',
                    //         fillColor: Colors.white,
                    //         filled: true),
                    //   ),
                    // ),

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please Enter your weight';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       weight = value;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide.none),
                    //         hintText: '80 kg',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //         labelText: 'Weight',
                    //         fillColor: Colors.white,
                    //         filled: true),
                    //   ),
                    // ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Blood Group';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          bloodGroup = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'AB',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Blood Group',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value!.isEmpty &&
                    //           (value.toLowerCase() != 'male' ||
                    //               value.toLowerCase() != 'female')) {
                    //         return 'Male or Female?';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       _gender = value;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide.none),
                    //         hintText: 'Male or Female',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //         labelText: 'Gender',
                    //         fillColor: Colors.white,
                    //         filled: true),
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value!.isEmpty || value.length != 14) {
                    //         return 'Please Enter your National ID Correctly';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       nationalID = value;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide.none),
                    //         hintText: '14-number length',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //         labelText: 'National ID',
                    //         fillColor: Colors.white,
                    //         filled: true),
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                    //   child: TextFormField(
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Enter your address';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       address = value;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide.none),
                    //         hintText: '14- Ramsis St- Minya ',
                    //         hintStyle: const TextStyle(color: Colors.black54),
                    //         labelText: 'Address',
                    //         fillColor: Colors.white,
                    //         filled: true),
                    //   ),
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 11) {
                            return 'Please Enter your phone number Correctly';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '+2010 9492 9414',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Phone Number',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '******',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'Password',
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),

                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: typeBorder)),
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(7),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.2,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  type = true;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: type != null
                                        ? ((type!) ? prmClr : bgClr)
                                        : bgClr,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                              ),
                            ),
                            const Text('Male'),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  type = false;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: type != null
                                        ? (!(type!) ? prmClr : bgClr)
                                        : bgClr,
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                              ),
                            ),
                            const Text('Female'),
                            const Spacer(),
                          ],
                        )),

                    InkWell(
                      child: isLoading
                          ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),color: prmClr
                            ),
                              margin: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : ButtonShape(
                              buttonText: 'Sign Up',
                              height: SizeConfig.screenHeight * 0.07,
                              width: SizeConfig.screenWidth * 0.7,
                            ),
                      onTap: () async {
                        if (_formkey.currentState!.validate() && type != null) {
                          await postPatients(context);
                        } else {}
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have An Account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            },
                            child: const Text('Login')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
