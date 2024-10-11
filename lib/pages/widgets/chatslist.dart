import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/chat/chatpage.dart';
import 'package:chat_app/pages/widgets/chattile.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ChatPage(),
            ));
          },
          child: ChatTitle(
            imgUrl: Assets.img.avatar.path,
            name: 'Nitish Kumar',
            lastChat: 'Bad me bat krta hu',
            lastTime: '9:23 PM',
          ),
        ),
      ],
    );
  }
}
