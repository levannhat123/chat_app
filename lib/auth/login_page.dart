import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/singup_page%20.dart';
import 'package:chat_app/components/button/button_elevated.dart';
import 'package:chat_app/components/text__flied/text__filed.dart';
import 'package:chat_app/components/text__flied/text_filed_pass.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/widgets/homepage.dart';

import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.email});
  final String? email;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.email ?? '';
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isStrongPassword(String password) {
    return password.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Image.asset(
                  Assets.img.login.path,
                  // fit: BoxFit.cover,
                  width: 200.0,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    color: AppColor.red,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField_chat(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFieldPass(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an password';
                    } else if (!isStrongPassword(value)) {
                      return 'Please enter a valid pasword';
                    } else {
                      return null;
                    }
                  },
                  controller: passController,
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    size: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColor.red),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SingUpPage(),
                            ));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: AppColor.blue),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Forgot PassWord",
                      style: TextStyle(color: AppColor.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await AuthController()
                        .login(emailController.text, passController.text);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: CappElevatedButton(text: "Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
