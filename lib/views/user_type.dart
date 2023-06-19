import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/person_type.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/size_config.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Want To register as a',
              style: titleStyle
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               PersonType(assetName:  'assets/images/patient.svg', width: SizeConfig.screenWidth*0.2, height: SizeConfig.screenHeight*0.3)
             ,  PersonType(assetName:  'assets/images/doctor-optimized.svg', width: SizeConfig.screenWidth*0.2, height: SizeConfig.screenHeight*0.3)
              ],
            )
          ],
        ),
      ),
    );
  }
}
