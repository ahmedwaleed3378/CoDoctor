import 'package:flutter/material.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/docinfo.dart';
import '../custom_widgets/info_container.dart';
import '../size_config.dart';

class DocEditingProfileScreen extends StatelessWidget {
  const DocEditingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<CoDoctorProvider>(context, listen: false).registeredDoctor;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(backgroundColor: prmClr,title: Text('Profile',style: subheadingStyle.copyWith(color: white),),),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
       
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: prmClr),
                  width: SizeConfig.screenWidth * 0.22,
                  child: Row(
                    children: [
                      Text(
                        'Edit',
                        style: titleStyle.copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.edit,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
            patientProfileInfoItem('First Name', '${provider.firstName}'),
            patientProfileInfoItem('Last Name', '${provider.lastName}'),
            patientProfileInfoItem('Email', '${provider.email}'),
            patientProfileInfoItem('Gender', 'Male'),
             patientProfileInfoItem('Phone Number', '01094929414'),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: prmClr),
              //  width: SizeConfig.screenWidth*0.17,
              child: Text(
                'Certificates',
                style: titleStyle.copyWith(color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
