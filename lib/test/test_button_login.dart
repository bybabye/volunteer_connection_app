import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_button_auth.dart';

class TestButtonLogin extends StatefulWidget {
  const TestButtonLogin({super.key});
  @override
  State<TestButtonLogin> createState() => _TestButtonLoginState();
}

class _TestButtonLoginState extends State<TestButtonLogin> {
  late String text;
  late Color color;
  late Function action;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Button"),
      ),
      body: Center(
        child: CustomButtonAuth(
          text: "Login",
          color: const Color(0xFF335CBE),
          action: () {},
        ),
      ),
    );
  }
}
