import 'dart:io';
import 'dart:math';

import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/imgpicker.dart';
import 'package:chat_app/components/appbarpage/chat_appbar.dart';
import 'package:chat_app/components/button/button_elevated.dart';
import 'package:chat_app/components/text__flied/text__filed.dart';
import 'package:chat_app/models/user__model.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProfileYour extends StatefulWidget {
  const ProfileYour({super.key});

  @override
  State<ProfileYour> createState() => _ProfileYourState();
}

UserModel? currentUser;

class _ProfileYourState extends State<ProfileYour> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Future<void> loadUserData() async {
    currentUser = await AuthController().getCurrentUser();
    print(currentUser);
    if (currentUser != null) {
      setState(() {
        nameController.text = currentUser!.name ?? "";
        emailController.text = currentUser!.email ?? "";
        phoneController.text = currentUser!.phone ?? '';
        imgurl = currentUser!.img ?? ''; // Lấy URL ảnh
      });
    }
  }

  ImgPicker picker = ImgPicker();
  String? imgurl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatAppbarPage(
          icon: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: "Update Profile",
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.bgColor),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  await picker.getImage();

                                  if (picker.image != null) {
                                    setState(() {
                                      imgurl = picker.imgUrl;
                                      print(imgurl);
                                    });
                                  }
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: AppColor.black,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: imgurl == null || imgurl!.isEmpty
                                      ? Icon(Icons.image)
                                      : ClipOval(
                                          child: imgurl!.startsWith('http')
                                              ? Image.network(
                                                  imgurl!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(
                                                      imgurl!), // Sử dụng Image.file cho ảnh cục bộ
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField_chat(
                                  hintText: "Name",
                                  controller: nameController,
                                  prefixIcon: Icon(Icons.person),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField_chat(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "emai@gmail.com",
                                  controller: emailController,
                                  readOnly: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField_chat(
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: "0815105572",
                                  controller: phoneController,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            CappElevatedButton(
                              text: "Save",
                              onPressed: () async {
                                await AuthController().UpdateProfile(
                                  imgurl ??
                                      'https://your-placeholder-image-url.com',
                                  nameController.text,
                                  phoneController.text,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
