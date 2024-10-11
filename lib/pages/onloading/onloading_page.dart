import 'package:chat_app/auth/login_page.dart';
import 'package:chat_app/components/button/button_elevated.dart';
import 'package:chat_app/models/onloading_model.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class OnloadingPage extends StatefulWidget {
  const OnloadingPage({super.key});

  @override
  State<OnloadingPage> createState() => _OnloadingPageState();
}

class _OnloadingPageState extends State<OnloadingPage> {
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Chat App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: AppColor.red),
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 240.0,
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  currentIndex = value;
                  setState(() {});
                },
                children: List.generate(
                    onloadings.length,
                    (index) => Image.asset(
                          onloadings[index].imgPath ?? '',
                          fit: BoxFit.fitHeight,
                        )),
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                onloadings[currentIndex].text ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColor.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onloadings.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.5),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: index == currentIndex ? 30.0 : 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: index == currentIndex
                              ? AppColor.red
                              : AppColor.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                )),
            const SizedBox(
              height: 56.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex > 0
                      ? CappElevatedButton.small(
                          onPressed: () {
                            currentIndex--;
                            pageController.jumpToPage(currentIndex);
                          },
                          text: "Back",
                        )
                      : CappElevatedButton.small(
                          onPressed: () {},
                          text: "Back",
                        ),
                  CappElevatedButton.small(
                      onPressed: () {
                        if (currentIndex < onloadings.length - 1) {
                          currentIndex++;
                          pageController.jumpToPage(currentIndex);
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      text: currentIndex == onloadings.length - 1
                          ? "Start"
                          : "Next")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
