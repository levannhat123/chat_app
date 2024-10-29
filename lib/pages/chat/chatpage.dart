import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/auth/chat_controller.dart';
import 'package:chat_app/components/appbarpage/chat_appbar.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/user__model.dart';
import 'package:chat_app/pages/chat/chatitem.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        icon: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<List<ChatAppModel>>(
          stream: chatController.getMessage(userModel.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Kiểm tra snapshot và dữ liệu trong snapshot trước khi tiếp tục
              print("No data found in snapshot");
              return Center(
                child: Text('No Message'),
              );
            } else {
              print("Data from snapshot: ${snapshot.data}");

              // Sử dụng Column để hiển thị các tin nhắn
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!.map((messageData) {
                    // In thông tin về message và timestamp
                    print("Message: ${messageData.message}");
                    print("Timestamp: ${messageData.timestamp}");

                    return ChatItem(
                      message: messageData.message ?? 'No message',
                      isComming: true, // Điều chỉnh theo logic của bạn
                      time: messageData.timestamp ?? 'Unknown',
                      status:
                          'read', // Có thể thay đổi tùy thuộc vào logic của bạn
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1),
          ),
          child: Row(
            children: [
              Icon(
                Icons.keyboard_voice_rounded,
                size: 28.0,
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: TextField(
                  controller: messagecontroller,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Type message ...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(Icons.image, size: 28.0),
              SizedBox(width: 10.0),
              InkWell(
                onTap: () {
                  if (messagecontroller.text.isNotEmpty) {
                    chatController.prepareAndSendMessage(
                      userModel.id!,
                      messagecontroller.text,
                    );
                    messagecontroller.clear();
                  }
                },
                child: Icon(Icons.send, size: 28.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
