// import 'dart:async';
// import 'dart:developer';
// import 'dart:html';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';

// import 'video_call.dart';
// class TestCall extends StatefulWidget {
//   const TestCall({super.key});

//   @override
//   State<TestCall> createState() => _TestCallState();
// }

// class _TestCallState extends State<TestCall> {

//   @override
//   void dispose() {
//     channelController.dispose();
//     super.dispose();
//   }
//   final channelController=TextEditingController(); 
// bool validateError=false;
// ClientRoleType role=ClientRoleType.clientRoleBroadcaster;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20),
          
//           child:Column(
//             children: [
//               SizedBox(height: 40,),
//                 TextField(
//                   controller: channelController,
//                 ),
//                 RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)




//             ],
//           ) ,
//         ),
//       ),
//     );
//   }
// }