import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/views/doctor_detail_screen.dart';
import 'package:flutter_project/views/login_screen.dart';
import 'package:flutter_project/views/patient_chats.dart';
import 'package:flutter_project/views/patient_profile.dart';

import 'package:flutter_project/views/symptoms_screen.dart';

import 'package:flutter_project/views/custom_widgets/headlines.dart';
import 'package:flutter_project/views/custom_widgets/info_item.dart';

import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/formprovider.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  bool isLoading = false;
  List<Doctor> doctors = [];
  List<Doctor> searchedFOrDoctors = [];
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    getDoctors();
  }

  getDoctors() async {
    setState(() {
      isLoading = true;
    });
    final List<dynamic> res =
        await Api().getMap(url: '$baseUrl/doctors/', name: 'doctors');
    doctors = res.map((e) => Doctor.fromjson(e)).toList();

    setState(() {
      isLoading = false;
    });
  }

  searchForDoctors(String docName) {
    searchedFOrDoctors = doctors.where((element) {
      return '${element.firstName.toLowerCase()} ${element.lastName.toLowerCase()}'
          .startsWith(docName);
    }).toList();
    setState(() {});
  }

  TextEditingController controller = TextEditingController();
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
          leading: Container(
            margin: const EdgeInsets.all(8),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                  provider = Patient(
                      firstName: '',
                      lastName: '',
                      gender: '',
                      id: '',
                      email: '');
                },
                icon: const Icon(
                  Icons.logout,
                  color: prmClr,
                )),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Home Page',
            style: headingStyle.copyWith(color: prmClr),
          ),
          elevation: 0,
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientEditingProfileScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.person,
                  color: prmClr,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 25, top: 15),
                    child: Text(
                      'Welcome, ${provider.firstName}',
                      style:
                          const TextStyle(color: darkHeaderClr, fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 48),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: prmClr),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SymptomScreen(),
                                ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Diagnose your symptoms',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const HeadLines(headLine: 'Find A Doctor'),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextField(
                        onTapOutside: (event) {
                          _focusNode.unfocus();

                          setState(() {
                            // searchedFOrDoctors.clear();
                            // controller.clear();
                          });
                        },
                        focusNode: _focusNode,
                        onTap: () {},
                        onChanged: (value) {
                          if (controller.text.isNotEmpty) {
                            searchForDoctors(controller.text);
                            setState(() {});
                          }
                          if (controller.text.isEmpty) {
                            setState(() {
                              searchedFOrDoctors.clear();
                            });
                          }
                        },
                        onSubmitted: (value) {},
                        controller: controller,
                        decoration: InputDecoration(
                            fillColor: const Color.fromRGBO(0, 0, 0, 0.25),
                            filled: true,
                            hintText: 'Search for Doctors',
                            hintStyle:
                                subtitleStyle.copyWith(color: Colors.white30),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            prefixIcon: Padding(
                                padding: const EdgeInsets.all(14),
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Icon(Icons.search))),
                      ),
                    ),
                  ),
                  searchedFOrDoctors.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: searchedFOrDoctors.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatientDoctorDetailsView(
                                              docId: searchedFOrDoctors[index]
                                                  .id!),
                                    ));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                elevation: 10,
                                color: white,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Dr. ${searchedFOrDoctors[index].firstName} ${searchedFOrDoctors[index].lastName}',
                                          style: titleStyle.copyWith(
                                              color: darkGreyClr),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 7, bottom: 7),
                                          child: Text(
                                            'Specialist: ${searchedFOrDoctors[index].medicalSpecialization}',
                                            style: bodyStyle.copyWith(
                                                color: darkGreyClr),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  const SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: SizeConfig.screenWidth * 0.2),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: prmClr),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PatientChatsScreen(),
                                ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Your Consultations',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const HeadLines(
                    headLine: 'Top Docotrs',
                    fontSize: 15,
                    opacity: 0.7,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: prmClr, borderRadius: BorderRadius.circular(15)),
                    margin:
                        EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                    width: SizeConfig.screenWidth * 0.93,
                    height: SizeConfig.screenHeight * 0.16,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset(
                            'assets/images/doctor-optimized.svg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.07),
                            child: doctors.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: white,
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        ' Dr. ${doctors[0].firstName} ${doctors[0].lastName}',
                                        style: subtitleStyle.copyWith(color: white),
                                      ),
                                      Text(
                                        '  ${doctors[0].medicalSpecialization}',
                                        style: subtitleStyle.copyWith(color: white),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const HeadLines(headLine: 'Categories'),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoItem(
                        icon: SvgPicture.asset(
                          'assets/images/i-dental.svg',
                          width: 20,
                          height: 20,
                        ),
                        value: '20 Doctors',
                        label: 'Dental',
                        width: SizeConfig.screenWidth * 0.25,
                      ),
                      InfoItem(
                        icon: const Icon(Icons.remove_red_eye)
                        // SvgPicture.asset('assets/images/i-.svg')

                        ,
                        value: '15 Doctors',
                        label: 'Eyes',
                        width: SizeConfig.screenWidth * 0.25,
                      ),
                      InfoItem(
                        icon: SvgPicture.asset(
                          'assets/images/i-cardiology.svg',
                          width: 20,
                          height: 20,
                        ),
                        value: '18 Doctors',
                        label: 'Cardiology',
                        width: SizeConfig.screenWidth * 0.25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // const HeadLines(headLine: 'Suggestions'),
                  // Container(
                  //   padding: const EdgeInsets.all(7),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(18), color: white),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       PersonType(
                  //         assetName: 'assets/images/doctor-optimized.svg',
                  //         width: SizeConfig.screenWidth * 0.09,
                  //         height: SizeConfig.screenHeight * 0.08,
                  //       ),
                  //       SizedBox(
                  //         width: SizeConfig.screenWidth * 0.05,
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Dr. Aliaa Osama',
                  //             style: titleStyle.copyWith(color: darkGreyClr),
                  //           ),
                  //           Text(
                  //             'Brain Specialist',
                  //             style: bodyStyle.copyWith(color: darkGreyClr),
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              )),
        ),
      ),
    );
  }
}
