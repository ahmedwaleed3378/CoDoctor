import 'dart:convert';
import 'dart:developer';
import 'package:flutter_project/views/chat_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/custom_widgets/forms_button_style.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/api_requests.dart';
import 'custom_widgets/info_item.dart';

class PatientDoctorDetailsView extends StatefulWidget {
  const PatientDoctorDetailsView({super.key, required this.docId});
  final String docId;
  @override
  State<PatientDoctorDetailsView> createState() =>
      _PatientDoctorDetailsViewState();
}

class _PatientDoctorDetailsViewState extends State<PatientDoctorDetailsView> {
  DateTime selectedhours = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String? date;
  String paymentMethod = 'VISA';
  bool isLoading = false;
  bool isbooking = false;

  book(String doctorId, String appointment, String patientToken,
      BuildContext context) async {
    setState(() {
      isbooking = true;
    });

    Map<String, dynamic> booking = {
      "doctorId": doctorId,
      "appointment": appointment
    };
    String jsonString = jsonEncode(booking);

    try {

      http.Response res = await http.post(
          Uri.parse('$baseUrl/patients/book/online'),
          body: jsonString,
          headers: {
            'Authorization': 'Bearer ${patientToken}',
            'Content-Type': 'application/json'
          });
      log(res.statusCode.toString());
      if (res.statusCode == 200) {
        Map<String, dynamic> decoding = jsonDecode(res.body);
        Provider.of<CoDoctorProvider>(context,listen: false).consultation =
            Consultation.fromjson(decoding['consulation']);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ChatScreen()));
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    setState(() {
      isbooking = false;
    });
  }

  getDocData() async {
    setState(() {
      isLoading = true;
    });

    log(widget.docId);
    Map<String, dynamic> res = await Api().getMap(
        url: '$baseUrl/doctors/${widget.docId}',
        name: 'doctor');

    log('55');
    Provider.of<CoDoctorProvider>(context, listen: false).docSearched =
        SearchedDoctor.fromjson(res);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDocData();
  }

    
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var provider = Provider.of<CoDoctorProvider>(context).docSearched;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [white, prmClr],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: SizeConfig.screenHeight * 0.1,
                      backgroundColor: Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.03,
                            ),
                            Text('${provider.firstName} ${provider.lastName}',
                                textAlign: TextAlign.start,
                                style: titleStyle.copyWith(color: prmClr)),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Text('${provider.specialization!.title}',
                          textAlign: TextAlign.center,
                          style: titleStyle.copyWith(color: prmClr)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoItem(
                              icon: const Icon(
                                Icons.person,
                                color: prmClr,
                              ),
                              label: 'Patients',
                              value: '22',
                              width: 85),
                          InfoItem(
                            icon: const Icon(
                              Icons.analytics,
                              color: prmClr,
                            ),
                            label: 'Experience',
                            value: '2 Years',
                            width: 105,
                          ),
                          InfoItem(
                            icon: const Icon(
                              Icons.star_border,
                              color: prmClr,
                            ),
                            label: 'Rating',
                            value:provider.rate==null?'5': '${provider.rate}',
                            width: 85,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          'Reviews',
                          style: subheadingStyle,
                        ),
                      ),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : provider.reviews!.length != 0
                              ? Container(
                                height: SizeConfig.screenHeight*0.4,
                                child: ListView.builder(
                                  
                                    padding: const EdgeInsets.all(10),
                                    itemCount: provider.reviews!.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: darkGreyClr,
                                                blurRadius: 3,
                                                offset: Offset(2, 4),
                                              )
                                            ],
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: prmClr.withOpacity(0.4)),
                                        margin: const EdgeInsets.all(5),
                                        child: Row(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'title:  ${provider.reviews![index].title}',
                                                  style: titleStyle.copyWith(
                                                      color: white),
                                                ),
                                                // Container(
                                                //     margin: const EdgeInsets.only(
                                                //         left: 4, top: 5),
                                                //     child: Text(
                                                //       'title:    ${provider.reviews![index].title}',
                                                //       style: bodyStyle.copyWith(
                                                //           fontSize: 15),
                                                //     )),
                                                Container(
                                                  width: SizeConfig.screenWidth*0.6,
                                                    margin: const EdgeInsets.only(
                                                        left: 4, top: 5),
                                                    child: Text(
                                                      'Note:    ${provider.reviews![index].description}',
                                                      style: subtitleStyle,
                                                      maxLines: null,
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
                                                  '${provider.reviews![index].rate}',
                                                  style: titleStyle.copyWith(
                                                      color: white),
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
                              )
                              : Container(
                                margin: EdgeInsets.only(left: 40),
                                child: Text('There is no reviews yet!',style: subtitleStyle.copyWith(color: darkGreyClr),),
                              ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          'Day',
                          style: subheadingStyle,
                        ),
                      ),
                  Container(
                        margin: const EdgeInsets.all(10),
                        child:DateTimePicker(
  type: DateTimePickerType.dateTimeSeparate,
  dateMask: 'd MMM, yyyy',
  initialValue: DateTime.now().toString(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
  icon: Icon(Icons.event),
  dateLabelText: 'Date',
  timeLabelText: "Hour",

  onChanged: (val) {
    date=val;
  } 
  ,
 
  onSaved: (val) {
    date=val;
  },
),
                        // DateTimePicker(
                        // firstDate: ,
                        // DateTime.now(),
                        // width: 80,
                        // height: 100,
                        // selectedTextColor: Colors.white,
                        // selectionColor: prmClr,
                        // onDateChange: (newDate) {
                        //   setState(() {
                        //     provider.updateDate(newDate);
                        //   });
                        // },
                        // dateTextStyle: GoogleFonts.lato(
                        //     textStyle: const TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w600)),
                        // monthTextStyle: GoogleFonts.lato(
                        //     textStyle: const TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w600)),
                        // dayTextStyle: GoogleFonts.lato(
                        //     textStyle: const TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w600)),
                        // initialSelectedDate: selectedDate,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          'Payment Method',
                          style: subheadingStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton<String>(
                            value: paymentMethod,
                            elevation: 15,
                            icon: Container(
                                margin: const EdgeInsets.only(right: 15),
                                child:
                                    const Icon(Icons.arrow_drop_down_outlined)),
                            isExpanded: true,
                            hint: const Text('Choose your Payment Method'),
                            borderRadius: BorderRadius.circular(10),
                            items: ['VISA', 'Fawry', 'Vodafone cash']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Text(value,
                                      style: subtitleStyle.copyWith(
                                          color: darkHeaderClr)),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                paymentMethod = newValue!;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          if (date != null && date!.isNotEmpty) {
                            // log(provider.id);
                            // log(date!);
                            // log( Provider.of<FormProvider>(context,
                            //             listen: false)
                            //         .patientRegistered
                            //         .patientToken!);
                            await book(
                                provider.id,
                                date!,
                                Provider.of<CoDoctorProvider>(context,
                                        listen: false)
                                    .registeredPatient
                                    .patientToken!,
                                context);
                          } else {
                            Alert(
                              context: context,
                              title: "Select the appointment",
                              //     desc: "try again Later",
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
                        child: isbooking
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : FormsButton(
                                buttonText: 'Reserve',
                                width: SizeConfig.screenWidth * 0.69),
                      )
                      // FormsButton(
                      //   buttonText: 'Contact',
                      //   width: SizeConfig.screenWidth * 0.36,
                      //   textColor: prmClr,
                      //   buttonColor: white,
                      // )
                      ,
                      const SizedBox(
                        height: 20,
                      )
                    ]))
                  ])),
      ),
    );
  }
}
