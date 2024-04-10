/// Author : Bùi lê Huy
/// Date : 08/04/2024
/// Description : Viết widget background
/// Update :
///

import 'package:flutter/material.dart';
import 'package:volunteer_connection/themes/app_assets.dart';
import 'package:volunteer_connection/themes/app_colors.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          bottom: height * -0.4,
          left: width * -0.5102,
          child: Transform.rotate(
            angle: -50 * 3.14159 / 180, // Chuyển đổi độ sang radian
            child: Container(
              width: width * 1.53,
              height: height,
              color: Appcolors.backgruondFirstColor,
            ),
          ),
        ),
        Positioned(
          top: 20,
          child: SizedBox(
            width: width,
            child: Center(
              child: Image.asset(
                AppAssets.logo,
              ),
            ),
          ),
        ),
        Positioned(
            child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: widget,
          ),
        ))
      ],
    );
  }
}
