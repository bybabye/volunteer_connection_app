import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar(
      {super.key, required this.size, required this.avatar});
  final double size;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size + 5,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(avatar),
        backgroundColor: Colors.greenAccent[100],
      ),
    );
  }
}
