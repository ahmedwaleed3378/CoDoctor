// import 'package:flutter/material.dart';
// import 'package:flutter_project/views/Doctor/medical_profile_view.dart';
// import 'package:flutter_project/views/custom_widgets/theme.dart';
// import 'package:flutter_project/views/size_config.dart';

// import '../custom_widgets/info_container.dart';

// class PatientProfileView extends StatelessWidget {
//   const PatientProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
//       backgroundColor: bgClr,
//       body: Container(
//         margin: const EdgeInsets.all(12),
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//               height: SizeConfig.screenHeight * 0.2,
//               width: SizeConfig.screenWidth * 0.3,
//               decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       fit: BoxFit.fitHeight,
//                       image: AssetImage('assets/images/DocShape.jpg'))),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Patient Name ',
//               style: headingStyle,
//             ),
//             patientProfileInfoItem('Phone Number   :', '01094929414'),
//             patientProfileInfoItem('Phone Number   :', '01094929414'),
//             patientProfileInfoItem('Phone Number   :', '01094929414'),
//             patientProfileInfoItem('Phone Number   :', '01094929414'),
//             ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(prmClr)),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DocMedicalProfile(),
//                       ));
//                 },
//                 child: Text(
//                   'Medical Profile ',
//                   style: titleStyle.copyWith(color: white),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
