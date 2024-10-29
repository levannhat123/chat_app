import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/chat_roomModel.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:chat_app/auth/auth_controller.dart';

class ChatController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  UserModel? currentUser = UserModel();
  var uuid = const Uuid();
  bool isLoading = false;

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  Future<void> loadUserData() async {
    currentUser = await AuthController().getCurrentUser();
  }

  Future<void> prepareAndSendMessage(
      String targetUserId, String message, UserModel targetUseR) async {
    await loadUserData();
    await sendMessage(targetUserId, message, targetUseR);
  }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUseR) async {
    isLoading = true;
    String chatId = uuid.v4();
    String roomId = getRoomId(targetUserId);
    var newChat = ChatAppModel()
      ..id = chatId
      ..message = message
      ..senderId = auth.currentUser!.uid
      ..receiverId = targetUserId
      ..senderName = currentUser!.name
      ..timestamp = DateTime.now().toIso8601String();

    var roomDetails = ChatRoomModel()
      ..id = roomId
      ..lastMessage = message
      ..lastMessageTimestamp = DateTime.now().toIso8601String()
      ..sender = currentUser
      ..receiver = targetUseR
      ..timestamp = DateTime.now().toIso8601String()
      ..unReadMessNo = 0;
    try {
      await db.collection('chats').doc(roomId).set(roomDetails.toJson());
      await db
          .collection('chats')
          .doc(roomId)
          .collection('messages')
          .doc(chatId)
          .set(newChat.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
    isLoading = false;
  }

  Stream<List<ChatAppModel>> getMessage(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => ChatAppModel.fromJson(e.data())).toList(),
        );
  }
}
