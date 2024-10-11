import 'package:flutter/material.dart';
import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/login_page.dart';
import 'package:chat_app/components/button/button_elevated.dart';
import 'package:chat_app/components/text__flied/text__filed.dart';
import 'package:chat_app/components/text__flied/text_filed_pass.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/resources/app_color.dart';

// Khai báo GlobalKey duy nhất cho Form
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController comfipassController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    comfipassController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isStrongPassword(String password) {
    return password.length >= 8;
  }

  bool isConfimpass() {
    return passController.text.trim() == comfipassController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey, // Sử dụng _formKey duy nhất
              child: Column(
                children: [
                  Image.asset(
                    Assets.img.login.path,
                    width: 200.0,
                  ),
                  const Text(
                    "Singup",
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextField_chat(
                    controller: comfipassController,
                    hintText: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                  const SizedBox(height: 16.0),
                  TextFieldPass(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (!isStrongPassword(value)) {
                        return 'Password must be at least 8 characters';
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
                  const SizedBox(height: 15.0),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Do you have an account? ",
                            style: TextStyle(color: AppColor.red),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: AppColor.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await AuthController().createUser(
                              emailController.text,
                              passController.text,
                              comfipassController.text);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                email: emailController.text.trim(),
                              ),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      }
                    },
                    child: CappElevatedButton(text: "Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
