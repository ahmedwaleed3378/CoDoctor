import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/api_requests.dart';
import 'package:flutter_project/views/custom_widgets/message_widget.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/patient_review_screen.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;
import '../models/classes.dart';
import '../models/formprovider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool socketConnected = false;
  bool meassageLoaded = false;
  List<Message> messages = [];
  String msg = '';
  FilePickerResult? result;
  dynamic _imageSelected;
  dynamic _imageSelected2;
  String? _fileName;
  Uint8List? fileU;
  String? imageURL;
  dynamic data;
  pickImage() async {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image, withData: true);

    if (result != null) {
      setState(() {
        _fileName = result!.files.first.path.toString();

        _imageSelected = FileImage(File(_fileName!));
      });
      fileU = result!.files.first.bytes;

      data = result!.files.first;
    }
  }

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

  TextEditingController controller = TextEditingController();
  sendMsg(String id, String token) async {
    Map<String, dynamic> jsonMap = {'content': '${controller.text}'};
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

//   sendMsg(String id, String token, {FilePickerResult? imageSelected}) async {
//     log(msg);
//     var request =
//         http.MultipartRequest('POST', Uri.parse('$baseUrl/user/chats/$id'));
//     request.headers['Authorization'] = 'Bearer $token';
//     request.headers['Content-Type'] = 'multipart/form-data';
// // Add form data to the request
//     request.fields['content'] = controller.text;
// // Add image file to the request
//     request.files.add(http.MultipartFile(
//       'attachedFile',
//       ByteStream.fromBytes(imageSelected!.files.first.bytes!),
//       imageSelected.files.first.size,
//       filename: imageSelected.files.first.name,
//     ));
//     http.StreamedResponse response = await request.send();
//     log(response.statusCode.toString());
//     log(response.toString());
// // log(await response.stream.bytesToString());
//   }

  @override
  void dispose() {
    super.dispose();
  }

  updateUi(dynamic c) {
    messages.add(Message.fromJson(c));
    setState(() {});
  }

  late IO.Socket socket;
  socketConnecting(String id) {
    try {
      socket.emit('setup', id);
      socket.connect();
      socket.onConnectError((err) => log('onConnectError $err'));
      socket.onConnect(
        (data) {
          log('Connected setup');
          setState(() {
            socketConnected = true;
          });
        },
      );
      socket.on('new-msg', (data) {
        log('$data');
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
    getMessages(
        Provider.of<CoDoctorProvider>(context, listen: false).chatId,
        Provider.of<CoDoctorProvider>(context, listen: false)
            .registeredPatient
            .patientToken!);
    socket = IO.io('https://codoctor.onrender.com', {
      'transports': ['websocket'],
      'reconnection': true,
      'reconnectionAttempts': 10,
      'timeout': 10000
    });
    socketConnecting(Provider.of<CoDoctorProvider>(context, listen: false)
        .registeredPatient
        .id);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var provider =
        Provider.of<CoDoctorProvider>(context, listen: false).consultation.chat;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Dr. ${provider!.name.split('-')[0]}',
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
                          builder: (context) => PatientReviewScreen(),
                        ));
                  },
                  icon: const Icon(Icons.reviews)),
            )
          ],
        ),
        body: !socketConnected
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MessageLine(
                            sender: messages[index].senderId ==
                                    Provider.of<CoDoctorProvider>(context)
                                        .registeredPatient
                                        .id
                                ? '${provider.name.split('-')[1]}'
                                : 'Dr. ${provider.name.split('-')[0]}',
                            text: messages[index].content,
                            isCurrent: messages[index].senderId ==
                                Provider.of<CoDoctorProvider>(context)
                                    .registeredPatient
                                    .id);
                      },
                    ),
                  ),
                  _imageSelected2 == null
                      ? Container()
                      : Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.all(10),
                          child: Image(
                            image: _imageSelected2,
                            width: 100,
                            height: 100,
                          ),
                        )
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
                          controller: controller,
                        )),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.mic)),
                        IconButton(
                            onPressed: () async {
                              await pickImage();
                            },
                            icon: const Icon(Icons.attach_file)),
                        TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                FocusScope.of(context).unfocus();
                                if (Provider.of<CoDoctorProvider>(context,
                                        listen: false)
                                    .chatId
                                    .isNotEmpty) {
                                  sendMsg(
                                    Provider.of<CoDoctorProvider>(context,
                                            listen: false)
                                        .chatId,
                                    Provider.of<CoDoctorProvider>(context,
                                            listen: false)
                                        .registeredPatient
                                        .patientToken!,
                                  );
                                } else {
                                  sendMsg(
                                    Provider.of<CoDoctorProvider>(context,
                                            listen: false)
                                        .consultation.chat!.id,
                                    Provider.of<CoDoctorProvider>(context,
                                            listen: false)
                                        .registeredPatient
                                        .patientToken!,
                                  );
                                }
                                controller.clear();
                              }

                              if (_imageSelected != null) {
                                setState(() {
                                  _imageSelected2 = _imageSelected;
                                  _imageSelected = null;
                                });
                              }
                            },
                            child: Text('send',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))
                      ],
                    ),
                  ),
                  _imageSelected == null
                      ? Container()
                      : Image(
                          image: _imageSelected,
                          width: 50,
                          height: 50,
                        )
                ],
              ));
  }
}
