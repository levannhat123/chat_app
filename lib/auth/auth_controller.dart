import 'dart:io';

import 'package:chat_app/models/user__model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  bool isLoading = false;
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Đăng nhập thành công');
    } on FirebaseAuthException catch (e) {
    } catch (e) {
      // Trả về thông điệp lỗi chung
      throw Exception('Đã xảy ra lỗi. Vui lòng thử lại sau.');
    }
  }

  Future<void> createUser(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await initUser(email, name);
      print('Tạo tài khoản thành công');
    } on FirebaseAuthException catch (e) {
      // Trả về mã lỗi để xử lý trong UI
    } catch (e) {
      // Trả về thông điệp lỗi chung
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

      // Dùng update thay vì set để tránh ghi đè dữ liệu khác
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
}
