import 'package:flutter/material.dart';

import 'package:flutter_project/views/custom_widgets/theme.dart';

class ProfImage extends StatelessWidget {
  const ProfImage({
    super.key,
    required this.imageUrl,
    required this.specialization,
    required this.rate,
    required this.height,
    required this.width, required this.docName,
  });
  final String imageUrl;
  final String specialization;
  final double rate;
  final double height;
  final double width;
  final String docName;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height * 0.1,
            width: width * 0.3,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fitHeight, image: NetworkImage(imageUrl))),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            docName,
            style: headingStyle,
          ),
          Text(
            specialization,
            style: subtitleStyle.copyWith(color: prmClr),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$rate',
                style: subtitleStyle,
              ),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.star,
                color: Color.fromARGB(255, 215, 215, 11),
              )
            ],
          )
        ],
      ),
    );
  }
}
