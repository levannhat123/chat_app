
import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/imgpicker.dart';
import 'package:chat_app/components/appbarpage/chat_appbar.dart';
import 'package:chat_app/components/text__flied/text__filed.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final AuthController authController = AuthController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ImgPicker picker = ImgPicker();
  String? imgurl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    setState(() {
      nameController.text =
          widget.userModel.name ?? ''; // Sử dụng roomModel để lấy tên
      emailController.text =
          widget.userModel.email ?? ''; // Cần đảm bảo roomModel có email
      phoneController.text = widget.userModel.phone ??
          ''; // Cần đảm bảo roomModel có số điện thoại
      imgurl = widget.userModel.img ??
          Assets.img.avatar.path; // Cần đảm bảo roomModel có ảnh
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatAppbarPage(
          icon: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: "Profile ${widget.userModel.name}",
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
                                  // await picker.getImage();

                                  // if (picker.image != null) {
                                  //   setState(() {
                                  //     imgurl = picker.imgUrl;
                                  //     print(imgurl);
                                  //   });
                                  // }
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
                                              : Image.asset(
                                                  Assets.img.avatar.path,
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
                                  readOnly: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            // CappElevatedButton(
                            //   text: "Save",
                            //   onPressed: () async {
                            //     await AuthController().UpdateProfile(
                            //       imgurl ??
                            //           'https://your-placeholder-image-url.com',
                            //       nameController.text,
                            //       phoneController.text,
                            //     );
                            //   },
                            // )
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
