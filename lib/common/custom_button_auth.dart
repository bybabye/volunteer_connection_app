/// Author : Lê thị thảo
/// Date : 06/03/2024
/// Description : Viết widget button cho phần authentication
/// Update :
///

import 'package:flutter/material.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth(
      {super.key,
      required this.width,
      required this.title,
      required this.func});
  final double width;
  final String title;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        height: 35,
        width: width,
        decoration: BoxDecoration(
            color: Appcolors.backgruondFirstColor,
            borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            title,
            style: AppStyles.h3.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
