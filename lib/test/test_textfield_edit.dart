import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_textfield_edit.dart';

class TestTextFieldEdit extends StatefulWidget {
  const TestTextFieldEdit({super.key});

  @override
  State<TestTextFieldEdit> createState() => _TestTextFieldEditState();
}

class _TestTextFieldEditState extends State<TestTextFieldEdit> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField Edit"),
      ),
      body: Center(
        child: CustomTextFieldEdit(
          height: 40,
          width: 280,
          placeHolder: "FullName",
          controller: _controller,
        ),
      ),
    );
  }
}
