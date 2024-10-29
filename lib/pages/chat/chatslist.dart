import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/chat/chatpage.dart';
import 'package:chat_app/pages/chat/chattile.dart'; // Đảm bảo ChatTitle được import từ đây
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/models/chat_roomModel.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final AuthController authController = AuthController();
  List<ChatRoomModel> chatRooms = [];

  @override
  void initState() {
    super.initState();
    loadChatRooms();
  }

  Future<void> loadChatRooms() async {
    await authController.getRoomList(); // Tải danh sách phòng chat
    setState(() {
      chatRooms = authController
          .chatRoom; // Gán danh sách phòng chat vào biến `chatRooms`
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chatRooms.isEmpty) {
      return const Center(child: Text('No chats available'));
    }

    return RefreshIndicator(
      child: ListView(
        children: chatRooms.map(
          (chatRoom) {
            DateTime time = DateTime.parse(
                chatRoom.lastMessageTimestamp ?? DateTime.now().toString());
            String formattedTime = DateFormat('hh:mm a').format(time);

            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(userModel: chatRoom.receiver!),
                ));
              },
              child: ChatTitle(
                imgUrl: chatRoom.receiver?.img ?? Assets.img.defaultAvatar.path,
                lastChat: chatRoom.lastMessage ?? 'Last Messages',
                name: chatRoom.receiver?.name ?? "User Name",
                lastTime: formattedTime,
              ),
            );
          },
        ).toList(),
      ),
      onRefresh: () async {
        await loadChatRooms();
      },
    );
  }
}
