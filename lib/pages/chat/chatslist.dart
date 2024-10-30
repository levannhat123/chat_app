import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/chat/chatpage.dart';
import 'package:chat_app/pages/chat/chattile.dart'; // Đảm bảo ChatTitle được import từ đây
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/models/chat_roomModel.dart';
import 'package:chat_app/models/user_model.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key, this.currentUser});
  final UserModel? currentUser;
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final AuthController authController = AuthController();
  List<ChatRoomModel> chatRooms = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRoomModel>>(
      stream: authController.getRoomListStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No chats available'));
        }

        final chatRooms = snapshot.data!;
        return ListView(
          children: chatRooms.map(
            (chatRoom) {
              DateTime time = DateTime.parse(
                  chatRoom.lastMessageTimestamp ?? DateTime.now().toString());
              String formattedTime = DateFormat('hh:mm a').format(time);

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatPage(
                        userModel:
                            (chatRoom.receiver?.id == widget.currentUser?.id
                                ? chatRoom.sender
                                : chatRoom.receiver)!),
                  )); 
                },
                child: ChatTitle(
                  imgUrl: chatRoom.receiver!.id == widget.currentUser!.id
                      ? chatRoom.sender?.img ?? Assets.img.avatar.path
                      : chatRoom.receiver?.img ?? Assets.img.avatar.path,
                  lastChat: chatRoom.lastMessage ?? 'Last Messages',
                  name: chatRoom.receiver!.id == widget.currentUser!.id
                      ? chatRoom.sender?.name ?? "User Name"
                      : chatRoom.receiver?.name ?? "User Name",
                  lastTime: formattedTime,
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
