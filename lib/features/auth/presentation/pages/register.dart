import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:volunteer_connection/common/custom_background.dart';
import 'package:volunteer_connection/common/custom_button_auth.dart';
import 'package:volunteer_connection/common/custom_textfield_auth.dart';
// import 'package:volunteer_connection/themes/app_colors.dart';
// import 'package:volunteer_connection/themes/app_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late double height;
  late double width;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomBackground(widget: _formRegister()),
    );
  }

  Widget _formRegister() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 470,
      width: width * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // Màu đen với độ trong suốt 25%
            offset: Offset(4, 4), // Độ lệch theo trục x và y
            blurRadius: 40, // Độ mờ
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldAuth(
            controller: _userName,
            hintText: "email@gmail.com",
            isPassword: false,
            title: "Email",
          ),
          CustomTextFieldAuth(
            controller: _password,
            hintText: "**************",
            isPassword: true,
            title: "Password",
          ),
          CustomTextFieldAuth(
            controller: _phoneNumber,
            hintText: "",
            isPassword: true,
            title: "Phone Number",
          ),
          CustomTextFieldAuth(
            controller: _fullName,
            hintText: "",
            isPassword: true,
            title: "Full Name",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                CustomButtonAuth(width: width, title: "Sign up", func: () {}),
          ),
        ],
      ),
    );
  }
}
