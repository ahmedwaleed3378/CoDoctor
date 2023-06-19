import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

import '../size_config.dart';

class ReservationRequests extends StatefulWidget {
  const ReservationRequests({super.key});

  @override
  State<ReservationRequests> createState() => _ReservationRequestsState();
}

class _ReservationRequestsState extends State<ReservationRequests> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Reservation Requests',style: headingStyle.copyWith(color: prmClr),),
                 SizedBox(height: SizeConfig.screenHeight*0.15,),
                Row(
                  children: [
                    Container(
                      height: SizeConfig.screenWidth * 0.08,
                      width: SizeConfig.screenWidth * 0.08,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1606166187734-a4cb74079037?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient Name',
                          style: titleStyle,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Clinic',
                          style: subtitleStyle,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'date',
                          style: body2Style,
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.check),iconSize: 30,
                    ),
                    const SizedBox(width: 10,),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),iconSize: 30,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
