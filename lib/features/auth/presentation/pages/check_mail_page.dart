import 'package:flutter/material.dart';
import 'package:volunteer_connection/config/app_colors.dart';
import 'package:volunteer_connection/features/auth/presentation/pages/login_page.dart';

class CheckMailPage extends StatelessWidget {
  const CheckMailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFf6f5ff),
                  ),
                  child: const Icon(
                    Icons.drafts,
                    color: AppColors.primary,
                    size: 60,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Check your mail',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'We have sent a password recover instructions to your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Container(
                //   alignment: Alignment.center,
                //   width: MediaQuery.of(context).size.width * 0.7,
                //   height: 50,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: AppColors.primary,
                //   ),
                //   child: const Text(
                //     'Open email app',
                //     style: TextStyle(
                //         fontSize: 16,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w500),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 80),
                GestureDetector(
                  onTap: () {
                    // Chuyển hướng tới trang login khi người dùng nhấn vào văn bản
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Skip, Login Now !',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold, // Để chữ in đậm
                      fontStyle: FontStyle.italic, // Để chữ in nghiêng
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text:
                            'Did not receive the email? Check your spam filter, or',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Try another email address',
                              style: TextStyle(
                                  color: AppColors.primary, fontSize: 14))
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
