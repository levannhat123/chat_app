import 'dart:ffi';
import 'dart:io';

import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/imgpicker.dart';
import 'package:chat_app/auth/login_page.dart';
import 'package:chat_app/components/button/button_elevated.dart';
import 'package:chat_app/components/td_app_bar.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/models/user__model.dart';
import 'package:chat_app/pages/chat/chatslist.dart';
import 'package:chat_app/profile/profile_your.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

UserModel? currentUser;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    loadUserData();
  }

  ImgPicker picker = ImgPicker();
  String? imgurl;
  Future<void> loadUserData() async {
    currentUser = await AuthController().getCurrentUser();
    setState(() {
      imgurl = currentUser!.img ?? "";
      print("Image URL: $imgurl"); // In giá trị của imgurl
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: TdAppBar(
        title: 'ChatApp',
        leftPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        tabController: tabController,
      ),
      drawer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0).copyWith(
            top: MediaQuery.of(context).padding.top + 6.0, bottom: 12.0),
        child: Drawer(
          backgroundColor: AppColor.bgColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.all(50),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColor.red,
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
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileYour(),
                        ));
                        // await loadUserData();
                      },
                      child: Icon(Icons.edit),
                    )
                  ],
                ),
                currentUser != null
                    ? Column(
                        children: [
                          Text(currentUser!.name ?? "",
                              style: TextStyle(fontSize: 18)),
                          Text(currentUser!.email ?? "",
                              style: TextStyle(fontSize: 14)),
                        ],
                      )
                    : CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: CappElevatedButton(
                    text: 'Logout',
                    onPressed: () async {
                      try {
                        await AuthController().logout();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      } catch (e) {}
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.bgColor,
        child: Icon(
          Icons.add,
          color: AppColor.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBarView(controller: tabController, children: [
          ChatList(),
          ListView(
            children: [Text('a')],
          ),
          ListView(
            children: [Text('b')],
          )
        ]),
      ),
    );
  }
}