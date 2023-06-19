import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

import '../size_config.dart';

class DocScheduleScreen extends StatefulWidget {
  const DocScheduleScreen({super.key});

  @override
  State<DocScheduleScreen> createState() => _DocScheduleScreenState();
}

class _DocScheduleScreenState extends State<DocScheduleScreen> {
  String s = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Your Schedule',
          style: headingStyle.copyWith(color: prmClr),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(18),
          child: Column(
            children: [
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(14),
                title: Text(
                  'Clinc Name',
                  style: titleStyle,
                ),
                children: [
                  tileItem(
                      'https://images.unsplash.com/photo-1606166187734-a4cb74079037?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                      'Patient Name',
                      'Clinic Name',
                      'Date'),
                  tileItem(
                      'https://images.unsplash.com/photo-1606166187734-a4cb74079037?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                      'Patient Name',
                      'Clinic Name',
                      'Date'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container tileItem(
      String imgUrl, String clinicName, String date, String patientName) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
    
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientName,
                style: titleStyle,
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    clinicName,
                    style: body2Style,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    date,
                    style: body2Style,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
            iconSize: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_2),
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
