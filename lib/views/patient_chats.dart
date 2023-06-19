import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/chat_screen.dart';
import 'package:flutter_project/views/custom_widgets/search_field.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'custom_widgets/theme.dart';

class PatientChatsScreen extends StatefulWidget {
  const PatientChatsScreen({super.key});

  @override
  State<PatientChatsScreen> createState() => _PatientChatsScreenState();
}

class _PatientChatsScreenState extends State<PatientChatsScreen> {
  TextEditingController controller = TextEditingController();
  List<Chat> chats = [];
  bool isLoading = true;
  fetchChats(String token) async {
    log(token);
    List<dynamic> doctors = [];
    http.Response response = await http.get(Uri.parse('$baseUrl/user/chats'),headers: {
      'Authorization': 'Bearer $token','Content-Type': 'application/json'
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> res = jsonDecode(response.body);
      doctors = res['chats'];
      log(doctors.toString());
      chats = doctors.map((json) => Chat.fromjson(json)).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchChats(Provider.of<CoDoctorProvider>(context, listen: false)
        .registeredPatient
        .patientToken!);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Your Consultations'),
      ),
      backgroundColor: const Color.fromRGBO(90, 102, 120, 1),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.all(12),
                      child: SearchField(
                        controller: controller,
                      )),
                  Expanded(
                    child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Provider.of<CoDoctorProvider>(context, listen: false)
                                  .chatId = chats[index].id;
                                    Provider.of<CoDoctorProvider>(context, listen: false)
                                  .consultation.chat=chats[index];
                              log(Provider.of<CoDoctorProvider>(context,
                                      listen: false)
                                  .chatId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChatScreen(),
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration:  BoxDecoration(
                                
                                
                                borderRadius: BorderRadius.circular(20),
                                
                                boxShadow: [
                                BoxShadow(
                                  spreadRadius: -15,
                                  color: darkGreyClr,
                                  blurRadius: 50,
                                  blurStyle: BlurStyle.normal,
                                )
                              ],color: white),
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dr. ${chats[index].name.split('-')[0]}',
                                        style: subtitleStyle.copyWith(color: darkGreyClr),
                                        textAlign: TextAlign.start,
                                      ),
                                       Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                        SizedBox(
                                            width: SizeConfig.screenWidth*0.65,
                                          ),     Text('22/10/${index+1}',
                                          style: body2Style,   textAlign: TextAlign.start,),
                                       
                                        ],
                                      ),const   SizedBox(
                                            height: 5,
                                          ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
