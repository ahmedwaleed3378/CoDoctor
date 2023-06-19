import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/docinfo.dart';
import 'package:flutter_project/views/custom_widgets/headlines.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/size_config.dart';

class OnlineReservationScreen extends StatelessWidget {
  const OnlineReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ProfImage(
               docName: 'Doctor',
                imageUrl:
                    'https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                specialization: 'specialization',
                rate: 4.5,
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth),
            Row(
              children: [
                Text(
                  'Price: ',
                  style: headingStyle,
                ),
                SizedBox(width: SizeConfig.screenWidth*0.2,),
                Text('55', style: subheadingStyle)
              ],
            ),
           const HeadLines(headLine: 'Work Appointments'),
          ]),
        ),
      ),
    );
  }
}
