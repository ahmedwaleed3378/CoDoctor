import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

import '../size_config.dart';

class DocProfileScreen extends StatelessWidget {
  const DocProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      backgroundColor: bgClr,
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.2,
                  width: SizeConfig.screenWidth * 0.3,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/images/DocShape.jpg'))),
                ),
                const SizedBox(height: 10),
                Text(
                  'Doctor Name ',
                  style: headingStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  'Specialization',
                  style: subheadingStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  '4.5',
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 70,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 8,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: darkGreyClr),
                    //     borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      children: [
                        const Icon(Icons.medical_services_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Clinics',
                          style: titleStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 8,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: darkGreyClr),
                    //     borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Phone Number',
                          style: titleStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 8,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: darkGreyClr),
                    //     borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Work Appointments',
                          style: titleStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 8,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: darkGreyClr),
                    //     borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      children: [
                        const Icon(Icons.credit_card),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Reservation Price',
                          style: titleStyle,
                        ),
                
                      ],
                    ),
                  ),
                ),        const SizedBox(
                          height: 28,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Reviews',
                            textAlign: TextAlign.start,
                            style: titleStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
              ],
            )),
      ),
    );
  }
}
