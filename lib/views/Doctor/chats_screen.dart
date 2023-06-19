import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/models/classes.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/Doctor/doc_chat_screen.dart';
import 'package:flutter_project/views/custom_widgets/search_field.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../custom_widgets/theme.dart';
import '../size_config.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  TextEditingController controller = TextEditingController();
  List<Chat> chats = [];
  bool isLoading = true;
  fetchChats(String token) async {
    log(token);
    List<dynamic> consultations = [];

    http.Response response = await http.get(Uri.parse('$baseUrl/user/chats'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });
    Map<String, dynamic> res = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      consultations = res['chats'];
      log(consultations.toString());
      chats = consultations.map((json) => Chat.fromjson(json)).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchChats(
        Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor.token!);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Doctor Name'),
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
                                  .chat = chats[index];
                              Provider.of<CoDoctorProvider>(context, listen: false)
                                  .chatPatientId = chats[index].patientId!;
                              log(Provider.of<CoDoctorProvider>(context,
                                      listen: false)
                                  .chatId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DocChatScreen(),
                                  ));
                            },
                            child: Container(
   padding: const EdgeInsets.all(4),
                          
                                
                                
                              
                                
                              decoration:  BoxDecoration(
                                color: white,
                                  borderRadius: BorderRadius.circular(20),
                                
                                boxShadow:const [
                                BoxShadow(
                                  spreadRadius: -15,
                                  color: darkGreyClr,
                                  blurRadius: 50,
                                  blurStyle: BlurStyle.normal,
                                )
                              ]),
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
                                        '${chats[index].name.split('-')[1]}',
                                        style: subtitleStyle.copyWith(
                                            color: darkGreyClr),
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '22/10${index}',
                                            style: body2Style.copyWith(
                                                color:darkGreyClr),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    'date',
                                    style: body2Style.copyWith(
                                        color: Colors.white30, fontSize: 15),
                                    textAlign: TextAlign.start,
                                  ),
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
