import 'package:flutter/material.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/medical_profile_edit.dart';
import 'package:flutter_project/views/size_config.dart';
import 'package:provider/provider.dart';

import 'custom_widgets/info_container.dart';

class PatientEditingProfileScreen extends StatelessWidget {
  const PatientEditingProfileScreen({super.key});

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
            backgroundColor: Colors.transparent,
            title: Text(
              ' Profile',
              style: headingStyle.copyWith(color: prmClr),
            ),
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: prmClr),
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
                    patientProfileInfoItem(
                        'First Name', '${provider.firstName}'),
                    patientProfileInfoItem('Last Name', '${provider.lastName}'),
                    patientProfileInfoItem('Email', '${provider.email}'),
                    patientProfileInfoItem('Gender', 'Male'),
                    patientProfileInfoItem('Phone Number', '01094929414'),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MedicalProfile(),
                          )),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: prmClr),
                        //  width: SizeConfig.screenWidth*0.17,
                        child: Text(
                          'Medical Profile',
                          style: titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
