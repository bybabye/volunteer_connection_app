import 'package:flutter/material.dart';

class TestButtonLogin extends StatelessWidget {
  const TestButtonLogin({required this.nameButton, super.key});
  final String nameButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Button"),
      ),
      body: Center(
        child: SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF335CBE),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              nameButton,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
