import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/login_screen.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/button_shape.dart';
import '../custom_widgets/theme.dart';
import '../size_config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'doc_home_page.dart';

class DocRegisterScreen extends StatefulWidget {
  const DocRegisterScreen({super.key});
  @override
  State<DocRegisterScreen> createState() => _DocRegisterScreenState();
}

class _DocRegisterScreenState extends State<DocRegisterScreen> {
  List<dynamic> specs = [];
  List<String> specsStrings = [];
  bool load = true;
  String specialization = 'Anesthesiology';
  List<MedicalSpecialization> specializations = [];
  String getLastSpecializtionId(String spec) {
    for (int i = 0; i < specializations.length; i++) {
      if (spec == specializations[i].title) {
        return specializations[i].id;
      }
    }
    return '0e2c34c8-a345-4f29-a6e0-49cf99fea55f';
  }

  postDoc() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> res = await Api().post(
        url: '$baseUrl/doctors/auth/signup',
        body: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "midName": '',
          "lastName": lastName,
          "gender": (type!) ? 'male' : 'female',
          "nationalId": nationalID,
          "specializationId": getLastSpecializtionId(specialization)
        });
    print(res['statusCode']);
    setState(() {
      _isRegitered = true;
    });

    if (_isRegitered) {
      docTOken = res['token'];
    }

    setState(() {
      isLoading = false;
    });
  }

  getSpecializations() async {
    specs = await Api().getMap(
        url: '$baseUrl/doctors/specializations',
        name: 'specializations') as List;
    specializations =
        specs.map((spec) => MedicalSpecialization.fromjson(spec)).toList();
    specsStrings = specializations.map((spec) => spec.title).toList();
    specsStrings = specsStrings.toSet().toList();
    if (specsStrings.isNotEmpty) {
      setState(() {
        load = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSpecializations();
  }

  String email = '';
  String age = '';
  String docTOken = '';
  String password = '';
  bool _isRegitered = false;
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

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length != 14) {
                            return 'Please Enter your National ID Correctly';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          nationalID = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: '14-number length',
                            hintStyle: const TextStyle(color: Colors.black54),
                            labelText: 'National ID',
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
                    // Container(
                    //   child: Column(
                    //     children:load?[CircularProgressIndicator()]: specsStrings.map((e) => Text(e)).toList(),
                    //   ),
                    // ),
                    dropDown(),
                    InkWell(
                      child: isLoading
                          ? Container(
                              margin: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: prmClr,
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
                        // Provider.of<FormProvider>(context, listen: false)
                        //             .docRegistered =
                        //         Doctor('firstName', 'lastName', 'specialization',
                        //             token: 'docTOken',rate: '0.0');
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => DoctorHomePage(),
                        // ));
                        if (_formkey.currentState!.validate() && type != null) {
                          await postDoc();
                          print(_isRegitered);
                          if (_isRegitered) {
                            Provider.of<CoDoctorProvider>(context, listen: false)
                                    .registeredDoctor =
                                Doctor(firstName, lastName, email,
                                    medicalSpecialization: specialization,
                                    token: docTOken,
                                    rate: '0.0');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorHomePage(),
                                ));
                          }
                        } else {
                          Alert(
                            context: context,
                            title: "Regetration Failed",
                            desc: "try again Later",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                color: const Color.fromRGBO(0, 179, 134, 1.0),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ).show();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have An Account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
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

  Container dropDown() {
    return Container(
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: load
          ? const CircularProgressIndicator()
          : DropdownButton<String>(
              value: specialization,
              style: titleStyle,
              dropdownColor: white,
              menuMaxHeight: SizeConfig.screenHeight * 0.4,
              isDense: true,
              padding: const EdgeInsets.all(15),
              iconSize: 30,
              elevation: 20,
              icon: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: const Icon(Icons.arrow_drop_down_outlined)),
              isExpanded: true,
              hint: const Text('Choose your Specialization'),
              borderRadius: BorderRadius.circular(10),
              items: (specsStrings.isEmpty
                      ? [
                          'Anesthesiology',
                          'load',
                        ]
                      : specsStrings)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      value,
                      style: subtitleStyle.copyWith(color: darkGreyClr),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  specialization = newValue!;
                });
              }),
    );
  }
}
