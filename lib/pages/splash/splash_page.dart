import 'dart:async';

import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/onloading/onloading_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      Route route = MaterialPageRoute(
        builder: (context) => const OnloadingPage(),
      );
      Navigator.pushAndRemoveUntil(
        context,
        route,
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Image.asset(
          Assets.img.splahs.path,
          width: 160.0,
        ),
      ),
    );
  }
}
