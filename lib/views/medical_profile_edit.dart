import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'custom_widgets/theme.dart';

class MedicalProfile extends StatefulWidget {
  const MedicalProfile({super.key});

  @override
  State<MedicalProfile> createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  bool isAdding = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? diseaseName;
  String? diseaseDesc;
  String? medicine;
  List<Map<String, String>> medicines = [];
  postDisease(String token) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> jsonMap = {
      "diseases": [
        {"name": diseaseName, "description": diseaseDesc}
      ],
      "medicines": medicines
      //  [
      //   {
      //     "name": "coldfree"
      //   }
      // ]
    };
    log(token);
    String jsonString = jsonEncode(jsonMap);
    Map<String, dynamic> res = await Api()
        .post(url: '$baseUrl/patients/profile', body: jsonString, token: token);

    setState(() {
      isAdding = false;
      isLoading = false;

      _formkey.currentState!.reset();
    });
    Alert(
      context: context,
      title: "Your Prescription is Added",
      desc: 'Please, Keep your medical profile updated',
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

  getDisease() async {}
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoDoctorProvider>(context).registeredPatient;
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
              'Patient Medical Profile',
              style: titleStyle.copyWith(color: prmClr, letterSpacing: 2),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ExpansionTile(
                      childrenPadding: const EdgeInsets.all(14),
                      title: Text(
                        'Prescriptions',
                        style: titleStyle,
                      ),
                      children: []
                      //  [
                      //   tileItem(
                      //       '',
                      //       'Patient Name',
                      //       'Clinic Name',
                      //       'Date'),
                      //   tileItem(
                      //       '',
                      //       'Patient Name',
                      //       'Clinic Name',
                      //       'Date'),
                      // ],
                      ),
                  const SizedBox(
                    height: 15,
                  ),
                  ExpansionTile(
                    childrenPadding: const EdgeInsets.all(14),
                    title: Text(
                      'Diseases',
                      style: titleStyle,
                    ),
                    children: provider.disease != null
                        ? provider.disease!
                            .map(
                              (e) => tileItem('', '', '${e.desc}', '${e.name}'),
                            )
                            .toList()
                        : [Text('there is no didseases')]
                    // [
                    //
                    //   tileItem('', 'Patient Name', 'Clinic Name', 'Date'),
                    // ]
                    ,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          if (!isAdding) {
                            setState(() {
                              isAdding = true;
                            });
                          } else {
                            setState(() {
                              isAdding = false;
                            });
                          }
                        },
                        child: Text(
                          'Add Prescription',
                          style: subheadingStyle,
                        )),
                  ),
                  isAdding
                      ? Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 20,
                          color: prmClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formkey,
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Disease Name',
                                        hintStyle: bodyStyle),
                                    style:
                                        bodyStyle.copyWith(color: Colors.white),
                                    onChanged: (value) {
                                      diseaseName = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Disease Description',
                                        hintStyle: bodyStyle),
                                    style:
                                        bodyStyle.copyWith(color: Colors.white),
                                    onChanged: (value) {
                                      diseaseDesc = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Medicines',
                                        hintStyle: bodyStyle),
                                    style:
                                        bodyStyle.copyWith(color: Colors.white),
                                    onChanged: (value) {
                                      medicine = value;
                                    },
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        log(provider.id);
                                        postDisease(provider.patientToken!);
                                      },
                                      child: isLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Text(
                                              'Add',
                                              style: subtitleStyle.copyWith(
                                                  color: white),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ));
  }

  Container tileItem(
      String imgUrl, String clinicName, String date, String patientName) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientName,
                style: titleStyle,
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    clinicName,
                    style: body2Style,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    date,
                    style: body2Style,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(
            width: 4,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_2),
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
