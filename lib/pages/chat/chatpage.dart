import 'package:chat_app/components/appbarpage/chat_appbar.dart';
import 'package:chat_app/components/text__flied/text__filed.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/chat/chatitem.dart';
import 'package:chat_app/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppbarPage(
        title: 'Lê Văn Nhật',
        subtitle: 'online',
        icon: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ChatItem(
              message: 'Heo con ăn cơm chưa',
              isComming: true,
              status: 's',
              time: '10:20 AM',
              imgUrl: '',
            ),
            ChatItem(
              message: 'Heo con ăn cơm chưa',
              isComming: false,
              status: 's',
              time: '10:20 AM',
              imgUrl: '',
            ),
            ChatItem(
              message: 'Heo con ăn cơm chưa',
              isComming: false,
              status: 's',
              time: '10:20 AM',
              imgUrl: Assets.img.login.path,
            ),
            ChatItem(
              message: 'Heo con ăn cơm chưa',
              isComming: true,
              status: 's',
              time: '10:20 AM',
              imgUrl: '',
            ),
            ChatItem(
              message: 'Heo con ăn cơm chưa',
              isComming: true,
              status: 's',
              time: '10:20 AM',
              imgUrl: Assets.img.login.path,
            ),
          ],
        ),
      ), // Add content to the body
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1)),
          child: const Row(
            children: [
              Icon(
                Icons.keyboard_voice_rounded,
                size: 28.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    filled: false,
                    hintText: 'Type message ...',
                    border: InputBorder.none),
              )),
              Icon(
                Icons.image,
                size: 28.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.send,
                size: 28.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
