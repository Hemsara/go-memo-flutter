// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gomemo/res/assets.dart';
import 'package:gomemo/res/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingWidget extends StatelessWidget {
  const MeetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List att = [
      "code94labs@gmail.com",
      "contact.vehanhemsara@gmail.com",
      "wathsaradesilva2000@gmail.com",
      "sathnidukottage@gmail.com"
    ];

    List colors = [
      // Color(0xffD9FFF8),
      Color(0xffFFFDF7),
      // Color(0xffD9FFF8),
      // Color(0xffD9FFF8),
    ];
    final random = Random();
    final randomColor = colors[random.nextInt(colors.length)];

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: randomColor,
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 20,
              color: Colors.grey.withOpacity(0.5),
            )
          ]),
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 23,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff388bfc),
                ),
              ),
              AppDimensions.space(1),
              Text(
                "Development project updates",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          Text(
            "11:30 – 12:00",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          AppDimensions.space(2),
          Wrap(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: att
                .map((e) => FittedBox(
                      child: Container(
                        margin: EdgeInsets.all(3),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.06),
                        ),
                        child: Text(
                          e.toString().split("@")[0],
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                      ),
                    ))
                .toList(),
          ),
          AppDimensions.space(2),
          Divider(
            color: Colors.black.withOpacity(0.1),
          ),
          AppDimensions.space(2),
          SvgPicture.asset(
            AppAssets.meetLogo,
            height: 25,
          ),
        ],
      ),
    );
  }
}
