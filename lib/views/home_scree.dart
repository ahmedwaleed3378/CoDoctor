import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/forms_button_style.dart';
import 'package:flutter_project/views/custom_widgets/prof_info_item.dart';
import 'package:flutter_project/views/size_config.dart';

import 'custom_widgets/docinfo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            ProfImage(
               docName: 'Doctor',
              imageUrl:
                  'https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              rate: 4.5,
              specialization: 'Eyes',
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
            ),
            FormsButton(
              buttonText: 'Edit',
              width: SizeConfig.screenHeight * 0.2,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            ProfileInfoItem(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                infoLabel: 'infoLabel',
                infoValue: 'infoValue'),
            ProfileInfoItem(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                infoLabel: 'infoLabel',
                infoValue: 'infoValue'),
            ProfileInfoItem(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                infoLabel: 'infoLabel',
                infoValue: 'infoValue'),
            ProfileInfoItem(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                infoLabel: 'infoLabel',
                infoValue: 'infoValue'),
            ProfileInfoItem(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                infoLabel: 'infoLabel',
                infoValue: 'infoValue'),
            ProfileInfoItem(
              
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                infoLabel: 'infoLabel',
                infoValue: 'infoValue'),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            FormsButton(
              buttonText: 'Certificates',
              width: SizeConfig.screenHeight * 0.32,
            ),
          ]),
        ),
      ),
    );
  }
}
