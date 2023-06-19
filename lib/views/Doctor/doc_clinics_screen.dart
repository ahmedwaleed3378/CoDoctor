import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../../models/api_requests.dart';

import '../size_config.dart';

class DocClinicsScreen extends StatefulWidget {
  const DocClinicsScreen({super.key});

  @override
  State<DocClinicsScreen> createState() => _DocClinicsScreenState();
}

class _DocClinicsScreenState extends State<DocClinicsScreen> {
  List<Clinic> clinics = [];
  bool isLoading = false;
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController timeFrom = TextEditingController();
  TextEditingController timeTo = TextEditingController();
  TextEditingController clinicName = TextEditingController();
  getClinics(BuildContext context) async {
    List<dynamic> res = await Api().getMap(
        url:
            '$baseUrl/doctors/${Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor.id}/clincs',
        name: 'clinics') as List<dynamic>;
    clinics = res.map((review) => Clinic.fromjson(review)).toList();
  }

  clearing() {
    clinicName.clear();
    location.clear();
    phone.clear();
    price.clear();
    price.clear();
    timeFrom.clear();
    timeTo.clear();
    setState(() {});
  }

  postClinic(token) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> jsonMap = {
      "name": clinicName.text,
      "phone": phone.text.toString(),
      "address": location.text,
      "reservationPrice": int.parse(price.text),
      "workAppointments": [
        {
          "day": "saturday",
          "from": timeFrom.text.toString(),
          "to": timeTo.text.toString()
        }
      ]
    };
    String jsonString = json.encode(jsonMap);

    try {
      log(token);
      http.Response res = await http.post(
        Uri.parse(
          '$baseUrl/doctors/clincs',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonString,
      );
      log('${res.statusCode}');
      log('${res.bodyBytes}');

      if (res.statusCode == 200 || res.statusCode == 201) {
        setState(() {
          added = true;
          isLoading = false;
        });
      }
      clearing();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  bool addingClinic = false;
  bool added = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoDoctorProvider>(context).registeredDoctor;
    SizeConfig().init(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [white, prmClr],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Your Clinics',
            style: subheadingStyle,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Clinics',
                      style: headingStyle.copyWith(color: prmClr),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            addingClinic = true;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 25,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                addingClinic
                    ? Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 20,
                        color: prmClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: clinicName,
                                      decoration: InputDecoration(
                                          hintText: 'Clinc Name',
                                          hintStyle: bodyStyle),
                                      style: bodyStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        log('message');
                                        if (clinicName.text.isNotEmpty &&
                                            location.text.isNotEmpty &&
                                            phone.text.isNotEmpty &&
                                            price.text.isNotEmpty &&
                                            int.tryParse(price.text) != null &&
                                            timeFrom.text.isNotEmpty &&
                                            timeTo.text.isNotEmpty) {
                                          await postClinic(provider.token);
                                          setState(() {
                                            addingClinic = false;
                                          });
                                          if (added) {
                                            Alert(
                                              context: context,
                                              title:
                                                  "Your Clinic is Added Successfuly",
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  color: const Color.fromRGBO(
                                                      0, 179, 134, 1.0),
                                                  child: const Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ).show();
                                          }
                                        }
                                      },
                                      icon: isLoading
                                          ? const CircularProgressIndicator(
                                              color: white,
                                            )
                                          : const Icon(Icons.done,
                                              color: Colors.white)),
                                  IconButton(
                                      onPressed: () {
                                        clearing();
                                        setState(() {
                                          addingClinic = false;
                                        });
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.white)),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              clinicInfoField(
                                  Icons.location_on, location, 'Location'),
                              clinicInfoField(Icons.phone, phone, 'Phone'),
                              clinicInfoField(
                                  Icons.credit_card, price, 'Price'),
                              Container(
                                margin: const EdgeInsets.all(7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.schedule, color: Colors.white),
                                    const Spacer(),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: 'From',
                                            contentPadding:
                                                const EdgeInsets.only(left: 5),
                                            hintStyle: bodyStyle),
                                        controller: timeFrom,
                                        textAlign: TextAlign.start,
                                        style: subtitleStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 17),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: 'To',
                                            contentPadding:
                                                const EdgeInsets.only(left: 5),
                                            hintStyle: bodyStyle),
                                        controller: timeTo,
                                        textAlign: TextAlign.start,
                                        style: subtitleStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 20,
                  color: prmClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Clinic Name',
                              style:
                                  subheadingStyle.copyWith(color: Colors.white),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit,
                                    color: Colors.white)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        clinicInfo(
                          'Clinic Location',
                          Icons.location_on,
                        ),
                        clinicInfo(
                          'Clinic Phone Number',
                          Icons.phone,
                        ),
                        clinicInfo(
                          'Available Time',
                          Icons.timer,
                        ),
                        clinicInfo(
                          'Price',
                          Icons.credit_card,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container clinicInfo(String info, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.white),
          const Spacer(),
          Text(
            info,
            textAlign: TextAlign.center,
            style: subtitleStyle.copyWith(color: Colors.white),
          ),
          const SizedBox(width: 12)
        ],
      ),
    );
  }

  Container clinicInfoField(
      IconData icon, TextEditingController controller, String hint) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.white),
          const Spacer(),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: bodyStyle,
                  contentPadding: const EdgeInsets.only(left: 5)),
              controller: controller,
              textAlign: TextAlign.start,
              style: subtitleStyle.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12)
        ],
      ),
    );
  }
}
