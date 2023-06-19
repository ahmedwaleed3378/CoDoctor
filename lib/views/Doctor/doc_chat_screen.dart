import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/views/Doctor/medical_profile_view.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/patient_review_screen.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;

import '../../models/classes.dart';
import '../../models/formprovider.dart';
import '../custom_widgets/message_widget.dart';

class DocChatScreen extends StatefulWidget {
  const DocChatScreen({super.key});

  @override
  State<DocChatScreen> createState() => _DocChatScreenState();
}

class _DocChatScreenState extends State<DocChatScreen> {
  bool meassageLoaded = false;
  List<Message> messages = [];
  String msg = '';
  getMessages(String chatId, String token) async {
    setState(() {
      meassageLoaded = true;
    });
    log(chatId);
    log(token);
    http.Response response =
        await http.get(Uri.parse('$baseUrl/user/chats/${chatId}'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    log(response.statusCode.toString());

    Map<String, dynamic> res1 = jsonDecode(response.body);
    List<dynamic> res = res1['chat']['messages'];
    messages = res.map((e) => Message.fromJson(e)).toList();
    setState(() {
      meassageLoaded = false;
    });
  }

  sendMsg(String id, String token) async {
    log(msg);
    Map<String, dynamic> jsonMap = {'content': msg};
    String jsonString = json.encode(jsonMap);

    log('$id');
    log('$id');
    log(jsonString);
    http.Response res = await http.post(Uri.parse('$baseUrl/user/chats/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonString);
    log(res.statusCode.toString());
    log(res.body);
  }

  @override
  void dispose() {
    socket.destroy();
    super.dispose();
  }

  getChat(String id, String token) async {}
  late IO.Socket socket;
  updateUi(dynamic c) {
    messages.add(Message.fromJson(c));
    setState(() {});
  }

  socketConnecting(String id) {
    try {
      socket.emit('setup', id);
      socket.connect();
      socket.onConnectError((err) => log('onConnectError $err'));
      socket.onConnect(
        (data) {
          log('Connected setup');
        },
      );
      socket.on('new-msg', (data) {
        updateUi(data);
      });
      socket.onError((err) => log('onError $err'));
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getMessages(Provider.of<CoDoctorProvider>(context, listen: false).chat.id,
        Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor.token!);
    socket = IO.io('https://codoctor.onrender.com', {
      'transports': ['websocket'],
      'reconnection': true,
      'reconnectionAttempts': 10,
      'timeout': 10000
    });
    socketConnecting(
        Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor.id!);
  }

  @override
  Widget build(BuildContext context) {
     var provider2 =
        Provider.of<CoDoctorProvider>(context, listen: false).chat;
    SizeConfig().init(context);
    var provider =
        Provider.of<CoDoctorProvider>(context, listen: false).patientChattedWith;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${provider2.name.split('-')[1]}',
                style: titleStyle.copyWith(color: Colors.white),
              ),
              Text(
                'online',
                style: subtitleStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: prmClr,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DocMedicalProfile(id: Provider.of<CoDoctorProvider>(context).chatPatientId),
                        ));
                  },
                  icon: const Icon(Icons.person)),
            )
          ],
        ),
        body: meassageLoaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(child: ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MessageLine(
                            sender: messages[index].senderId ==
                                    Provider.of<CoDoctorProvider>(context)
                                        .registeredDoctor.id
                                ? '${provider2!.name.split('-')[1]}'
                                : 'Dr. ${provider2!.name.split('-')[0]}',
                            text: messages[index].content,
                            isCurrent: messages[index].senderId ==
                                Provider.of<CoDoctorProvider>(context)
                                    .registeredDoctor
                                    .id);
                      },
                    ),)

                  //  Container(child: Text(  Provider.of<FormProvider>(context,listen: false).consultation.chat!.name),),
                  ,
                  Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(top: BorderSide(width: 2, color: prmClr))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write your message here...',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20)),
                          onChanged: ((value) {
                            msg = value;
                          }),
                        )),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.mic)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file)),
                        TextButton(
                            onPressed: () {
                              if (msg.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                                sendMsg(
                                    Provider.of<CoDoctorProvider>(context,
                                            listen: false)
                                        .chat.id,
                                    Provider.of<CoDoctorProvider>(context,
                                            listen: false)
                                        .registeredDoctor
                                        .token!);
                                // socket.on('new-msg', (data) {
                                //   // messages.add(Message.fromjson(data));
                                //   log('$data');
                                // });
                              }
                            },
                            child: Text('send',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))
                      ],
                    ),
                  )
                ],
              ));
  }
}
