import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/components/appbarpage/chat_appbar.dart';
import 'package:chat_app/components/chat_search_box.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat/chatpage.dart';
import 'package:chat_app/pages/chat/chattile.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final AuthController _authController = AuthController();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    setState(() {
      _authController.isLoading = true;
    });
    await _authController.getUserList();
    setState(() {
      _authController.isLoading = false;
      searchList = _authController.userList.toList();
    });
  }

  void _search(String value) {
    value = value;
    setState(() {
      searchList = _authController.userList
          .where((e) => (e.name ?? '').contains(value))
          .toList();
    });
  }

  List<UserModel> searchList = [];
  List<UserModel> userModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppbarPage(
        icon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: "Select Contact",
        subtitle: "${_authController.userList.length} người",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatSearchBox(controller: searchController, onChanged: _search),
              const SizedBox(height: 10),

              const Text("Danh sách Chats:"),
             
              _authController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: searchList
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                        userModel: e,
                                      ),
                                    ));
                              },
                              child: ChatTitle(
                                imgUrl: e.img ?? 'a',
                                name: e.name ?? "",
                                lastChat: '',
                                lastTime: '',
                              ),
                            ),
                          )
                          .toList(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
