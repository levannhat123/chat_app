import 'dart:io';

import 'package:chat_app/models/chat_roomModel.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  bool isLoading = false;
  List<UserModel> userList = [];
  List<UserModel> searchList = [];
  List<ChatRoomModel> chatRoom = [];
  Future<void> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        print('Đăng nhập thành công');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Email không tồn tại. Vui lòng kiểm tra lại.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Mật khẩu không chính xác. Vui lòng thử lại.');
      } else {
        throw Exception('Đã xảy ra lỗi. Vui lòng thử lại sau.');
      }
    } catch (e) {
      throw Exception('Đã xảy ra lỗi. Vui lòng thử lại sau.');
    }
  }

  Future<void> createUser(String email, String password, String name) async {
    try {
      await db.disableNetwork();
      final userSnapshot =
          await db.collection("users").where("email", isEqualTo: email).get();
      await db.enableNetwork();

      // Kiểm tra nếu email đã tồn tại
      if (userSnapshot.docs.isNotEmpty) {
        throw FirebaseAuthException(
            code: "email-already-in-use", message: "Email đã tồn tại");
      }

      // Tạo người dùng Firebase Auth
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Khởi tạo thông tin người dùng Firestore
      await initUser(email, name);
      print('Tạo tài khoản thành công');
    } on FirebaseAuthException catch (e) {
      print("Lỗi FirebaseAuth: ${e.message}");
      throw Exception(e.message ?? 'Đăng ký thất bại');
    } catch (e) {
      throw Exception('Đã xảy ra lỗi. Vui lòng thử lại sau.');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> initUser(String email, String name) async {
    var newUser = UserModel(
      email: email,
      name: name,
      id: _auth.currentUser!.uid,
    );
    try {
      await db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (ex) {
      print(ex);
    }
  }

  void onInit() async {
    await getCurrentUser();
  }

  Future<UserModel?> getCurrentUser() async {
    if (_auth.currentUser != null) {
      var userSnapshot =
          await db.collection("users").doc(_auth.currentUser!.uid).get();
      if (userSnapshot.exists) {
        return UserModel.fromJson(userSnapshot.data()!);
      }
    }
    return null;
  }

  Future<void> UpdateProfile(
      String imageUrl, String name, String number) async {
    isLoading = true;
    try {
      final imgLink = imageUrl.startsWith('http')
          ? imageUrl
          : await UpdateFileProfile(imageUrl);
      final updateUser = UserModel(
          name: name,
          phone: number,
          img: imgLink,
          id: _auth.currentUser!.uid,
          email: _auth.currentUser!.email);
      await db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .update(updateUser.toJson());
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }

  Future<String> UpdateFileProfile(String imageUrl) async {
    final path =
        "files/${_auth.currentUser!.uid}/profile_image"; // Đảm bảo đường dẫn duy nhất cho mỗi người dùng
    final file = File(imageUrl);

    if (imageUrl.isNotEmpty) {
      try {
        final ref = store.ref().child(path).putFile(file);
        final upload = await ref.whenComplete(() => {});
        final downloadUrl = await upload.ref.getDownloadURL();
        print(downloadUrl);
        return downloadUrl; // Trả về URL mới
      } catch (e) {
        print(e);
        return '';
      }
    }
    return '';
  }

  Future<void> getUserList() async {
    isLoading = true;
    try {
      await db.collection("users").get().then(
            (value) => {
              userList =
                  value.docs.map((e) => UserModel.fromJson(e.data())).toList(),
              searchList = [...userList],
            },

            // setState(() {});
          );
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ChatRoomModel>> getRoomListStream() {
    return db
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      List<ChatRoomModel> temRoomList =
          snapshot.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList();
      return temRoomList
          .where((element) => element.id!.contains(_auth.currentUser!.uid))
          .toList();
    });
  }
}
