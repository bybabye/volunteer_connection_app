import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_textfield_edit.dart';

class TestTextFieldEdit extends StatefulWidget {
  const TestTextFieldEdit({super.key});

  @override
  State<TestTextFieldEdit> createState() => _TestTextFieldEditState();
}

class _TestTextFieldEditState extends State<TestTextFieldEdit> {
  final TextEditingController _controller = TextEditingController();

  int indexSelected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField Edit"),
      ),
      body: Center(
          child: Column(
        children: [
          CustomTextField(
            controller: _controller,
            index: 0,
            indexSelected: indexSelected,
            onTap: () {
              setState(() {
                indexSelected = 0;
              });
            },
            isPassword: false,
          ),
          CustomTextField(
            controller: _controller,
            index: 1,
            indexSelected: indexSelected,
            onTap: () {
              setState(() {
                indexSelected = 1;
              });
            },
            isPassword: false,
          ),
        ],
      )),
    );
  }
}
