import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    required this.text,
    required this.color,
    required this.action,
  });
  final String text;
  final Color color;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: ElevatedButton(
        // onPressed:action();
        onPressed: () {
          action();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
