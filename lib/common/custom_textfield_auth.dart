/// Author : Lê thị thảo
/// Date : 06/03/2024
/// Description : Viết widget textfield cho phần authentication
/// Update :
///

import 'package:flutter/material.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class CustomTextFieldAuth extends StatelessWidget {
  const CustomTextFieldAuth(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isPassword,
      required this.title});
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.h4.copyWith(
              fontWeight: FontWeight.w600,
              color: Appcolors.backgruondFirstColor),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 40,
          decoration: const BoxDecoration(color: Color(0xFFF1F4F5)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: AppStyles.h4,
            ),
            obscureText: isPassword,
          ),
        ),
      ],
    );
  }
}
