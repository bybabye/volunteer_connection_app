import 'package:flutter/material.dart';

class CustomTextFieldEdit extends StatefulWidget {
  const CustomTextFieldEdit({
    super.key,
    required this.height,
    required this.width,
    required this.placeHolder,
    required this.controller,
  });
  final double height;
  final double width;
  final String placeHolder;
  final TextEditingController controller;
  @override
  State<CustomTextFieldEdit> createState() => _CustomTextFieldEditState();
}

class _CustomTextFieldEditState extends State<CustomTextFieldEdit> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.placeHolder,
        ),
      ),
    );
  }
}
