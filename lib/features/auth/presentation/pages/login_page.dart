/// Author : Bùi lê Huy
/// Date : 08/04/2024
/// Description : Viết login page
/// Update :
///

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/common/custom_background.dart';
import 'package:volunteer_connection/common/custom_button_auth.dart';
import 'package:volunteer_connection/common/custom_textfield_auth.dart';
import 'package:volunteer_connection/core/routers/navigation_service.dart';
import 'package:volunteer_connection/core/routers/routes.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:volunteer_connection/themes/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double height;
  late double width;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();
  late AuthProvider _auth;
  bool isLoading = false;
  void saveNameToLocal(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nameLocal', name);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: CustomBackground(
          widget: isLoading ? const CircularProgressIndicator() : _formLogin()),
    );
  }

  Widget _formLogin() {
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              width: width,
              child: Text(
                "Forgot Password?",
                style: AppStyles.h5.copyWith(
                    color: Appcolors.backgruondFirstColor,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButtonAuth(
                width: width,
                title: "Login",
                func: () async {
                  setState(() {
                    isLoading = !isLoading;
                  });
                  Map<String, String> result =
                      await _auth.login(_userName.text, _password.text);
                  if (result['success'] != null) {
                    await _auth.getUser(result['success']!);
                    String nameLocal = _auth.user.name.toString();
                    saveNameToLocal(nameLocal);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Success"),
                      backgroundColor: Colors.green,
                    ));
                    navigationService.goToPage(Routes.home);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(result['error'] ?? ""),
                      backgroundColor: Colors.red,
                    ));
                  }
                  setState(() {
                    isLoading = !isLoading;
                  });
                }),
          ),
          _lineField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _customButton(FontAwesomeIcons.facebookF, () => {},
                  Appcolors.backgruondFirstColor),
              const SizedBox(
                width: 20,
              ),
              _customButton(
                  FontAwesomeIcons.google, () => {}, const Color(0xFFDB4437)),
            ],
          ),
          _richText(),
        ],
      ),
    );
  }

  Widget _lineField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1, // Độ cao của dòng ngang
              color: Colors.black, // Màu của dòng ngang
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10), // Khoảng cách giữa dòng ngang và chữ "or"
            child: Text(
              "or",
              style: AppStyles.h5.copyWith(
                  color: const Color(0xFF808080)), // Font size của chữ "or"
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _richText() {
    return InkWell(
      onTap: () {
        navigationService.goPage(Routes.register);
      },
      child: Center(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "Don't have an account? ",
              style: AppStyles.h5.copyWith(
                  color: const Color(0xFF597CD2), fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: "Sign up",
              style: AppStyles.h5.copyWith(
                color: Appcolors.backgruondFirstColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _customButton(IconData icon, Function() func, Color color) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // Màu đen với độ trong suốt 25%
            offset: Offset(4, 4), // Độ lệch theo trục x và y
            blurRadius: 40, // Độ mờ
          ),
        ],
      ),
      height: 35,
      width: 35,
      child: Center(
        child: IconButton(
          onPressed: func,
          icon: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
      ),
    );
  }
}
