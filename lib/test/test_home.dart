import 'package:flutter/material.dart';
import 'package:volunteer_connection/test/test_item_notification.dart';
import 'package:volunteer_connection/test/test_textfield_edit.dart';
import 'package:volunteer_connection/test/test_button_login.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TestTextFieldEdit(),
                ),
              ),
              child: const Text("Text textfield Edit"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TestItemNotification(),
                ),
              ),
              child: const Text("Text item notification"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TestButtonLogin(
                    nameButton: "Login",
                  ),
                ),
              ),
              child: const Text("Test button login"),
            )
          ],
        ),
      ),
    );
  }
}
