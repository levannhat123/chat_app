import 'package:chat_app/auth/chat_controller.dart';
import 'package:chat_app/components/appbarpage/chat_appbar.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/profile/profile_user.dart';
import 'package:intl/intl.dart';

import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/pages/chat/chatitem.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = ChatController();
    final TextEditingController messagecontroller = TextEditingController();

    return Scaffold(
      appBar: ChatAppbarPage(
        title: userModel.name ?? '',
        subtitle: 'online',
        icon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: AppColor.black),
        ),
        img: userModel.img ?? '',
        rightPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileUser(
                  userModel: userModel,
                ),
              ));
        },
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 70, top: 10, left: 10, right: 10),
        child: StreamBuilder<List<ChatAppModel>>(
          stream: chatController.getMessage(userModel.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Message'),
              );
            } else {
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DateTime time =
                      DateTime.parse(snapshot.data![index].timestamp!);
                  String format = DateFormat('hh:mm a').format(time);
                  return GestureDetector(
                    onLongPressStart: (details) {
                 
                    },
                    child: ChatItem(
                      message: snapshot.data![index].message!,
                      isComming: snapshot.data![index].senderId == userModel.id,
                      time: format,
                      status: 'read',
                      imgUrl: '',
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_voice_rounded,
                size: 28.0,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextField(
                  controller: messagecontroller,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: 'Type message ...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Icon(
                Icons.image,
                size: 28.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: () {
                  if (messagecontroller.text.isNotEmpty) {
                    chatController.prepareAndSendMessage(
                        userModel.id!, messagecontroller.text, userModel);
                    messagecontroller.clear();
                  }
                },
                child: const Icon(
                  Icons.send,
                  size: 28.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
