import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/Doctor/chats_screen.dart';
import 'package:flutter_project/views/Doctor/doc_clinics_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/views/Doctor/doc_schedule_screen.dart';
import 'package:flutter_project/views/Doctor/reservation_requests.dart';
import 'package:flutter_project/views/custom_widgets/docinfo.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

import 'package:provider/provider.dart';

import '../login_screen.dart';
import '../size_config.dart';
import 'doc_profile_editing_screen.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  List<Review> reviews = [];
  bool isLoading = false;


  getReviews() async {
    setState(() {
      isLoading=true;
    });
    log(Provider.of<CoDoctorProvider>(context,listen: false).registeredDoctor.id.toString());
    try {
  http.Response response = await http.get(Uri.parse(
      '$baseUrl/doctors/${Provider.of<CoDoctorProvider>(context,listen:false).registeredDoctor.id}/reviews'));
  Map<String, dynamic> res = jsonDecode(response.body);
  log(res['reviews'].toString());
  // List<dynamic> res = await Api().getMap(
  //     url:
  //         '$baseUrl/doctors/${Provider.of<FormProvider>(context).docRegistered.id}/reviews',
  //     name: 'reviews');
 List<dynamic> not=res['reviews'];
  reviews = not.map((review) {
    return Review.fromjson(review);
  }).toList();
} on Exception catch (e) {
  log(e.toString());
}
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoDoctorProvider>(context).registeredDoctor;
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [white, prmClr],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                provider=Doctor('', '', '',token: '');
                },
                icon: const Icon(
                  Icons.logout,
                  color: prmClr,
                )),
          ),
          centerTitle: true,
          title: Text(
            'Home Page ',
            selectionColor: Colors.black,
            style: headingStyle.copyWith(color: prmClr),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 70),
                        child: IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatsScreen(),
                                )),
                            icon: Icon(Icons.message,
                                color: prmClr,
                                size: SizeConfig.screenWidth * 0.1)),
                      ),
                      Text(
                        'Welcome \n Dr.${provider.firstName}',
                        style: subheadingStyle.copyWith(color: prmClr),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 70),
                        child: IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ReservationRequests(),
                                )),
                            icon: Icon(
                              Icons.book_online_outlined,
                              color: prmClr,
                              size: SizeConfig.screenWidth * 0.1,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocEditingProfileScreen(),
                            ));
                      },
                      child: Text(
                        'View Profile',
                        style: titleStyle.copyWith(color: Colors.grey.shade600),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              backgroundColor:
                                  MaterialStateProperty.all(prmClr)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DocClinicsScreen(),
                                ));
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Icon(
                                Icons.medical_information_sharp,
                                size: SizeConfig.screenWidth * 0.07,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Clinics',
                                style: headingStyle.copyWith(color: white),
                              )
                            ],
                          ))),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            backgroundColor: MaterialStateProperty.all(prmClr)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DocScheduleScreen(),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Icon(
                              Icons.schedule,
                              size: SizeConfig.screenWidth * 0.07,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Schedule',
                              style: headingStyle.copyWith(color: white),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(height: 15),
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                          
                              getReviews();
                            },
                            child: Text(
                              'Reviews',
                              style: subheadingStyle,
                            ),
                          )
                        ],
                      )),
                  isLoading
                      ?const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                        height: SizeConfig.screenHeight*0.5,
                        
                        child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: reviews.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${reviews[index].patient!.firstName} ${reviews[index].patient!.lastName}',
                                          style: subheadingStyle.copyWith(
                                              color: white),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 4, top: 5),
                                            child: Text(
                                              'title:    ${reviews[index].title}',
                                              style: bodyStyle.copyWith(
                                                  fontSize: 15),
                                            )),
                                        Container(
                                          width: SizeConfig.screenWidth*0.6,
                                            margin: const EdgeInsets.only(
                                                left: 4, top: 5),
                                            child: Text(
                                              'Note:    ${reviews[index].description}',
                                              style: bodyStyle,
                                              maxLines: 4,
                                              softWrap: true,
                                            )),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${reviews[index].rate}',
                                          style:
                                              titleStyle.copyWith(color: white),
                                        ),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
