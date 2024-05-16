import 'package:flutter/material.dart';

import 'package:volunteer_connection/themes/app_styles.dart';

class CustomTextFieldSearch extends StatelessWidget {
  const CustomTextFieldSearch({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFEFEFEF),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          hintText: "Tìm kiếm ...",
          hintStyle: AppStyles.h4,
        ),
      ),
    );
  }
}
