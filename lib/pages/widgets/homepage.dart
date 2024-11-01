import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/imgpicker.dart';
import 'package:chat_app/auth/login_page.dart';
import 'package:chat_app/components/button/button_elevated.dart';
import 'package:chat_app/components/appbarpage/td_app_bar.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat/chatslist.dart';
import 'package:chat_app/pages/contact/contactpage.dart';
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
    tabController = TabController(length: 1, vsync: this);
    loadUserData();
  }

  ImgPicker picker = ImgPicker();
  String? imgurl;
  Future<void> loadUserData() async {
    currentUser = await AuthController().getCurrentUser();
    setState(() {
      imgurl = currentUser!.img ?? "";
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
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
        padding: EdgeInsets.symmetric(horizontal: 0).copyWith(
          top: MediaQuery.of(context).padding.top + 6.0,
          bottom: 12.0,
        ),
        child: Drawer(
          backgroundColor: AppColor.bgColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile section
                Container(
                  // color: AppColor.bgColor, // Màu nền cho phần Profile
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      // Avatar với viền đẹp mắt
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                  color: Color.fromARGB(255, 28, 184, 236),
                                  width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: imgurl == null || imgurl!.isEmpty
                                  ? Image.asset(Assets.img.defaultAvatar.path,
                                      fit: BoxFit.cover)
                                  : (imgurl!.startsWith('http')
                                      ? Image.network(imgurl!,
                                          fit: BoxFit.cover)
                                      : Image.asset(Assets.img.avatar.path,
                                          fit: BoxFit.cover)),
                            ),
                          ),
                          // Icon chỉnh sửa
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileYour()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.edit,
                                    size: 20, color: AppColor.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Thông tin người dùng
                      if (currentUser != null) ...[
                        Text(
                          "Name: ${currentUser!.name ?? "Unknown User"}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Email: ${currentUser!.email ?? "No email available"}",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ] else
                        const CircularProgressIndicator(),
                    ],
                  ),
                ),
                // Divider
                // Nút logout
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CappElevatedButton(
                    text: 'Logout',
                    onPressed: () async {
                      try {
                        await AuthController().logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      } catch (e) {
                        throw Exception(e.toString());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactPage(),
          ));
        },
        backgroundColor: AppColor.bgColor,
        child: const Icon(
          Icons.add,
          color: AppColor.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ChatList(currentUser: currentUser),
      ),
    );
  }
}
