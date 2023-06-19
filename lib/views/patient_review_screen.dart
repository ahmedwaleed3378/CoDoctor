import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/custom_widgets/forms_button_style.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wheel_slider/wheel_slider.dart';
import 'package:http/http.dart' as http;
import 'custom_widgets/theme.dart';

class PatientReviewScreen extends StatefulWidget {
  const PatientReviewScreen({super.key});

  @override
  State<PatientReviewScreen> createState() => _PatientReviewScreenState();
}

//
class _PatientReviewScreenState extends State<PatientReviewScreen> {
  postReviews(String docId, String token) async {
    Map<String, dynamic> jsonMap = {
      "doctorId": docId,
      "title": title,
      "description": desc,
      "rate": rate
    };
    String jsonString = jsonEncode(jsonMap);
    setState(() {
      isLoading = true;
    });
    http.Response res = await Api().postRes(
        url: '$baseUrl/patients/doctor-review', body: jsonString, token: token);
    setState(() {
      isLoading = false;
    });
    if (res.statusCode == 200 || res.statusCode == 201)
      Alert(
        context: context,
        title: "Your review is added",
        desc: "Thanks!",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: const Color.fromRGBO(0, 179, 134, 1.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    else
      Alert(
        context: context,
        title: "Failed to add the revies",
        desc: "Try agian later",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: const Color.fromRGBO(0, 179, 134, 1.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
  }

  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String title = '';
  String desc = '';
  int rate = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [white, prmClr],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Review Your Doctor',
              style: subheadingStyle.copyWith(color: prmClr),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(13),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field Can\'t be Empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          title = value;
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: 'ex: Very Good',
                          hintStyle: const TextStyle(color: Colors.black54),
                          labelText: 'Title',
                          fillColor: white2,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14.0, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This Field Can\'t be Empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          desc = value;
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          labelText: 'Description',
                          hintStyle: const TextStyle(color: Colors.black54),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rate',
                          style: headingStyle,
                          textAlign: TextAlign.start,
                        )),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: WheelSlider.customWidget(
                        totalCount: 5,
                        initValue: 1,
                        isInfinite: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        onValueChanged: (val) {
                          setState(() {
                            rate = val;
                          });
                        },
                        horizontalListWidth: 190,
                        hapticFeedbackType: HapticFeedbackType.vibrate,
                        showPointer: true,
                        customPointer: Container(
                            margin: const EdgeInsets.only(
                                left: 40, top: 5, bottom: 5, right: 0),
                            child: const Icon(
                              Icons.star,
                              color: orangeClr,
                            )),
                        itemSize: 90,
                        children: List.generate(
                            5,
                            (index) => Center(
                                    child: Text(
                                  (1 + index).toString(),
                                  style: titleStyle,
                                ))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(20),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10)),
                              backgroundColor: MaterialStateProperty.all(prmClr),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)))),
                          onPressed: () {
                            if (_formkey.currentState!.validate() && rate != 0) {
                              postReviews(
                                  Provider.of<CoDoctorProvider>(context,
                                          listen: false)
                                      .docSearched
                                      .id,
                                  Provider.of<CoDoctorProvider>(context,
                                          listen: false)
                                      .registeredPatient
                                      .patientToken!);
                            } else {
                              Alert(
                                context: context,
                                title: "Please Provide All Data",
                                desc: "",
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
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  'Send',
                                  style: headingStyle.copyWith(color: white),
                                )),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
