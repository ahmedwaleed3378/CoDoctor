import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/docinfo.dart';
import 'package:flutter_project/views/custom_widgets/prof_info_item.dart';
import 'package:flutter_project/views/custom_widgets/styles_textfield.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';
import 'package:flutter_project/views/size_config.dart';

class CertificationsScreen extends StatelessWidget {
  const CertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfImage(
                 docName: 'Doctor',
                imageUrl:
                    'https://images.pexels.com/photos/15784893/pexels-photo-15784893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                rate: 4.5,
                specialization: 'Eyes',
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
              ),
             Row(
              children: [
             const   SizedBox(width: 20,),
                Text('Certifications',style: headingStyle.copyWith(color: Styles.themeColor),),
           const Spacer(),   const  Icon(Icons.add,size: 25,),const   SizedBox(width: 10,),
              ],
             ),
        
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
               color: const Color.fromRGBO(90, 102, 120,1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete,color: white,),
                          style:
                              ButtonStyle(elevation: MaterialStateProperty.all(10)),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit,color: white,),
                          style:
                              ButtonStyle(elevation: MaterialStateProperty.all(10)),
                        ),
                      ],
                    ),
                 
                    ProfileInfoItem(
                      
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        infoLabel: 'Certificate Destination : ',
                        infoValue: 'Ministry Of Health'),
                    ProfileInfoItem(
                      
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        infoLabel: 'Certificate Image : ',
                        infoValue: 'Certificate1.pdf'),
                  ],
                ),
              ),
           
         
           
            ],
          ),
        ),
      ),
    );
  }
}
